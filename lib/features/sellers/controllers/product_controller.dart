import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/models/product_model.dart';
import 'package:ryve_mobile/core/models/seller_model.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';

class ProductController extends ChangeNotifier {
  String _getUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/";
  Map<String, String> _headers = {};

  List sizes = [];
  List add_on_groups = [];
  Map selectedSize = {};
  String displayPrice = "";
  Map selectedAddOns =
      {}; // {aog_id: {require: int, num_of_select: int, addOns: List of add on ids, addOnPrices: List of add on prices} }
  int quan_of_prod = 1;
  late SellerModel seller;
  late ProductModel product;

  void setHeader() {
    _headers = Headers.getHeaders();
    print(_headers);
  }

  void getProductDetails(product) async {
    String _dataUrl = _getUrl + "?id=${product.id}";
    Map _response = await SharedFunction.getData(_dataUrl, _headers);
    Map _responseBody = _response['body'];

    sizes = _responseBody['sizes'];
    if (sizes.length == 1) {
      displayPrice = sizes[0]['price'].toStringAsFixed(2);
      selectedSize["product_price_id"] = sizes[0]['product_price_id'];
      selectedSize["price"] = sizes[0]['price'];
    }
    add_on_groups = _responseBody['add_on_groups'];
    for (var aog in add_on_groups) {
      selectedAddOns[aog['id']] = {
        "require": aog['require'],
        "num_of_select": aog['num_of_select'],
        "addOns": [],
        "addOnPrices": []
      };
    }
    seller = SellerModel.fromJson(_responseBody['seller']);
    this.product = product;
    notifyListeners();
  }

  bool selected(size) {
    return selectedSize["product_price_id"] == size['product_price_id'];
  }

  void setSize(size) {
    selectedSize["product_price_id"] = size['product_price_id'];
    selectedSize["price"] = size['price'];
    notifyListeners();
  }

  void checkAddOns(Map addOn, bool selected) {
    if (selected) {
      int _addOnsRequire = selectedAddOns[addOn['add_on_group_id']]['require'];
      // if required then cannot unselect, and the user should select another choice
      if (_addOnsRequire == 0) {
        selectedAddOns[addOn['add_on_group_id']]['addOns'].remove(addOn['id']);
        selectedAddOns[addOn['add_on_group_id']]['addOnPrices']
            .remove(addOn['price']);
      }
    } else {
      List _addOns = selectedAddOns[addOn['add_on_group_id']]['addOns'];
      int _numberOfSelected =
          selectedAddOns[addOn['add_on_group_id']]['num_of_select'];
      // check if add on selected hasn't selected any yet
      if (_addOns.isEmpty) {
        selectedAddOns[addOn['add_on_group_id']]['addOns'].add(addOn['id']);
        selectedAddOns[addOn['add_on_group_id']]['addOnPrices']
            .add(addOn['price']);
      } else {
        // check number of items can be selected
        if (_numberOfSelected == _addOns.length) {
          selectedAddOns[addOn['add_on_group_id']]['addOns'].removeAt(0);
          selectedAddOns[addOn['add_on_group_id']]['addOnPrices'].removeAt(0);
        }

        selectedAddOns[addOn['add_on_group_id']]['addOns'].add(addOn['id']);
        selectedAddOns[addOn['add_on_group_id']]['addOnPrices']
            .add(addOn['price']);
      }
    }
    notifyListeners();
  }

  void quantityMinus() {
    if (quan_of_prod > 1) {
      quan_of_prod--;
    }
    notifyListeners();
  }
  void quantityAdd() {
    if (quan_of_prod > 1) {
      quan_of_prod--;
    }
    notifyListeners();
  }
  double getTotalAmount() {
    // get price of size
    double _sizePrice = selectedSize["price"] == null
        ? 0
        : selectedSize["price"];
    double _addOnPrice = 0;

    if (selectedAddOns.isNotEmpty) {
      selectedAddOns.forEach((key, value) {
        _addOnPrice += value["addOnPrices"].isEmpty
            ? 0
            : value["addOnPrices"].reduce((a, b) => a + b);
      });
    }

    double _total = quan_of_prod * (_sizePrice + _addOnPrice);
    return _total;
  }
  void addToCart(context) async {
    if (selectedSize["product_price_id"] == null) {
      PopUp.error(context, "Please choose one size");
      return;
    }

    // check if add on required is not selected
    int check = 0;
    selectedAddOns.forEach((key, value) {
      if (value["addOns"].length < value["require"]) {
        check = 1;
      }
    });

    if (check == 1) {
      PopUp.error(context, "Please select on of the required add ons");
      return;
    }

    // send data to back end
    List _addOnsIds = [];
    selectedAddOns.forEach((key, value) {
      _addOnsIds.add(value["addOns"]);
    });

    Map _data = {
      "product_id": product.id,
      "seller_id": seller.id,
      "product_price_id": selectedSize["product_price_id"],
      "quantity": quan_of_prod,
      "add_on_ids": _addOnsIds,
    };

    String _url = _getUrl + "carts";
    Map _response = await SharedFunction.sendData(_url, _headers, _data);

    if (_response["status"] == 200) {
      Navigator.pop(context);
    } else {
      PopUp.error(context, "error in server");
    }
  }
}
