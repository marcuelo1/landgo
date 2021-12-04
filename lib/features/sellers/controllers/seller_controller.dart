import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/models/product_model.dart';
import 'package:ryve_mobile/core/models/seller_model.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';

class SellerController extends ChangeNotifier {
  String _getUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/";

  Map<String, String> _headers = {};

  List category_deals = []; // category deals
  List<SellerModel> top_sellers = []; // top_sellers
  List<SellerModel> recent_sellers = []; // recent_sellers
  List<SellerModel> all_sellers = []; // all sellers

  List product_categories = [];
  List<ProductModel> products = [];

  List sizes = [];
  List add_on_groups = [];
  Map selectedSize = {};
  String displayPrice = "";
  Map selectedAddOns =
      {}; // {aog_id: {require: int, num_of_select: int, addOns: List of add on ids, addOnPrices: List of add on prices} }
  int quan_of_prod = 1;
  late SellerModel seller;
  late ProductModel product;
  UnmodifiableListView<SellerModel> get topSellers =>
      UnmodifiableListView(top_sellers);
  UnmodifiableListView<SellerModel> get recentSellers =>
      UnmodifiableListView(recent_sellers);
  UnmodifiableListView<SellerModel> get allSellers =>
      UnmodifiableListView(all_sellers);

  void setHeader() {
    _headers = Headers.getHeaders();
    print(_headers);
  }

  void getSellersData(category) async {
    print("GETTING SELLERS DATA");
    // get headers
    setHeader();
    //get url
    String url = _getUrl + "sellers?id=${category['id']}";
    // request data from the server
    Map _response = await SharedFunction.getData(url, _headers);
    Map _responseBody = _response['body'];

    top_sellers = SellerModel.fromJson(_responseBody['top_sellers']);
    recent_sellers = SellerModel.fromJson(_responseBody['recent_sellers']);
    all_sellers = SellerModel.fromJson(_responseBody['all_sellers']);

    category_deals = _responseBody['category_deals'];
    print("=============================");
    print(_responseBody);

    notifyListeners();
  }

  void getSpecificSeller(seller) async {
    setHeader();
    String _dataUrl = _getUrl + "sellers/${seller.id}";

    Map _response = await SharedFunction.getData(_dataUrl, _headers);
    Map _responseBody = _response['body'];
    product_categories = _responseBody['product_categories'];
    // get products
    products = ProductModel.fromJson(_responseBody['products']);

    notifyListeners();
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
