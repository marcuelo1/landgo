import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/features/sellers/styles/product_style.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);
  static const String routeName = "product";

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // url
  String _dataUrl =
      "${SharedUrl.root}/${SharedUrl.version}/buyer/product_details";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double productImageWidth = 325;
  final double productImageHeight = 200;
  final double quantityBarWidth = 100;
  final double quantityBarHeight = 35;
  final double addToBasketBtnWidth = 300;
  final double addToBasketBtnHeight = 60;

  Map seller = {};
  Map product = {};
  List sizes = [];
  List add_on_groups = [];
  String displayPrice = "";

  // selected
  Map selectedSize = {};
  Map selectedAddOns =
      {}; // {aog_id: {require: int, num_of_select: int, addOns: List of add on ids, addOnPrices: List of add on prices} }
  int quan_of_prod = 1;

  // response
  Map response = {};
  Map responseBody = {};
  // headers
  Map<String, String> _headers = {};
  @override
  void initState() {
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    product = args['product'];
    print(product);
    _dataUrl = _dataUrl + "?id=${product['id']}";

    return responseBody.isEmpty
        ? FutureBuilder(
            future: SharedFunction.getData(_dataUrl, _headers),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // Connection state of getting the data
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("check internet");
                case ConnectionState.waiting: // Retrieving
                  return Loading();
                default: // Success of connecting to back end
                  // check if snapshot has an error
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  // get response
                  response = snapshot.data;
                  responseBody = response['body'];
                  print(responseBody);
                  print(
                      "==============================================================");

                  sizes = responseBody['sizes'];
                  // check if product has only one size, so we can display at the bottom of product name
                  if (sizes.length == 1) {
                    displayPrice = sizes[0]['price'].toStringAsFixed(2);
                    selectedSize["product_price_id"] =
                        sizes[0]['product_price_id'];
                    selectedSize["price"] = sizes[0]['price'];
                  }

                  // get add on groups
                  add_on_groups = responseBody['add_on_groups'];
                  print(add_on_groups);
                  print(
                      "==============================================================");
                  for (var aog in add_on_groups) {
                    selectedAddOns[aog['id']] = {
                      "require": aog['require'],
                      "num_of_select": aog['num_of_select'],
                      "addOns": [],
                      "addOnPrices": []
                    };
                  }
                  print(selectedAddOns);
                  print(
                      "==============================================================");

                  seller = responseBody['seller'];

                  return content();
              }
            })
        : content();
  }

  Widget content() {
    return SafeArea(
        child: Scaffold(
      appBar: SharedWidgets.appBar(context, title: seller['name']),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: SharedFunction.scaleWidth(327, width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(20, height),
                ),
                // product image
                productImage(product['image']),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(10, height),
                ),
                // product name
                productName(product['name']),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(5, height),
                ),
                // product description
                productDescription(product['description']),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(7, height),
                ),
                // product price
                if (sizes.length == 1) ...[
                  productPrice(displayPrice),
                  // space
                  SizedBox(
                    height: SharedFunction.scaleHeight(30, height),
                  ),
                ],
                // product size
                if (sizes.length > 1) ...[
                  productSizes(sizes),
                  // space
                  SizedBox(
                    height: SharedFunction.scaleHeight(30, height),
                  ),
                ],
                // product add ons
                if (add_on_groups.length > 0) ...[
                  productAddOns(add_on_groups),
                  // space
                  SizedBox(
                    height: SharedFunction.scaleHeight(30, height),
                  ),
                ],
                // Quantity
                quantity(),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(30, height),
                ),
                // Total
                total(),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(45, height),
                ),
                // Add to cart
                addToBasketBtn(),
                // space
                SizedBox(
                  height: SharedFunction.scaleHeight(80, height),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget productImage(String url) {
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
            side: BorderSide(width: 1, color: SharedStyle.tertiaryFill)),
        child: ClipRRect(
          borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget productName(String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: ProductStyle.productName,
    );
  }

  Widget productDescription(String _description) {
    return Text(
      _description,
      textAlign: TextAlign.center,
      style: ProductStyle.productDescription,
    );
  }

  Widget productPrice(String price) {
    return Text("₱$price",
        textAlign: TextAlign.center, style: ProductStyle.productPrice);
  }

  Widget productSizes(List _sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // name
        title("Sizes"),
        // space
        SizedBox(
          height: SharedFunction.scaleHeight(10, height),
        ),
        // sizes
        for (var size in _sizes) ...[
          productSizeDetail(size),
          // space
          SizedBox(
            height: SharedFunction.scaleHeight(10, height),
          )
        ]
      ],
    );
  }

  Widget productSizeDetail(Map size) {
    String _name = size['size'];
    bool selected =
        selectedSize["product_price_id"] == size['product_price_id'];

    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedSize["product_price_id"] = size['product_price_id'];
            selectedSize["price"] = size['price'];
          });
        },
        style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // name
            subTitle(_name, selected),
            // price
            priceDisplay(size['price'], size['base_price'], selected),
          ],
        ));
  }

  Widget productAddOns(List addOnGroups) {
    return Column(
      children: [
        for (var aog in addOnGroups) ...[addOnGroup(aog)]
      ],
    );
  }

  Widget addOnGroup(Map aog) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title(aog['name'], aog['require'].toString()),
        // space
        SizedBox(
          height: SharedFunction.scaleHeight(10, height),
        ),
        // add ons
        for (var add_on in aog['add_ons']) ...[
          // add on
          addOn(add_on),
          // space
          SizedBox(
            height: SharedFunction.scaleHeight(10, height),
          )
        ]
      ],
    );
  }

  Widget addOn(Map ao) {
    String _name = ao['name'];
    String _price = ao['price'].toStringAsFixed(2);
    bool selected =
        selectedAddOns[ao['add_on_group_id']]['addOns'].contains(ao['id']);

    return ElevatedButton(
        onPressed: () {
          if (selected) {
            int _addOnsRequire =
                selectedAddOns[ao['add_on_group_id']]['require'];
            // if required then cannot unselect, and the user should select another choice
            if (_addOnsRequire == 0) {
              setState(() {
                selectedAddOns[ao['add_on_group_id']]['addOns']
                    .remove(ao['id']);
                selectedAddOns[ao['add_on_group_id']]['addOnPrices']
                    .remove(ao['price']);
              });
            }
          } else {
            setState(() {
              List _addOns = selectedAddOns[ao['add_on_group_id']]['addOns'];
              int _numberOfSelected =
                  selectedAddOns[ao['add_on_group_id']]['num_of_select'];
              // check if add on selected hasn't selected any yet
              if (_addOns.isEmpty) {
                selectedAddOns[ao['add_on_group_id']]['addOns'].add(ao['id']);
                selectedAddOns[ao['add_on_group_id']]['addOnPrices']
                    .add(ao['price']);
              } else {
                // check number of items can be selected
                if (_numberOfSelected == _addOns.length) {
                  selectedAddOns[ao['add_on_group_id']]['addOns'].removeAt(0);
                  selectedAddOns[ao['add_on_group_id']]['addOnPrices']
                      .removeAt(0);
                }

                selectedAddOns[ao['add_on_group_id']]['addOns'].add(ao['id']);
                selectedAddOns[ao['add_on_group_id']]['addOnPrices']
                    .add(ao['price']);
              }
            });
          }
        },
        style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // name
            subTitle(_name, selected),
            // price
            subTitle("₱$_price", selected),
          ],
        ));
  }

  Widget quantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // title
        plainTitle("Quantity"),
        //
        quantityBar()
      ],
    );
  }

  Widget quantityBar() {
    return Container(
      width: SharedFunction.scaleWidth(quantityBarWidth, width),
      height: SharedFunction.scaleHeight(quantityBarHeight, height),
      decoration: ProductStyle.quantityBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [quantityMinus(), quantityNum(), quantityAdd()],
      ),
    );
  }

  Widget quantityMinus() {
    return Center(
      child: IconButton(
        onPressed: () {
          if (quan_of_prod > 1) {
            setState(() {
              quan_of_prod--;
            });
          }
        },
        icon: Icon(
          Icons.remove,
        ),
        color: SharedStyle.red,
      ),
    );
  }

  Widget quantityAdd() {
    return Center(
      child: IconButton(
        onPressed: () {
          setState(() {
            quan_of_prod++;
          });
        },
        icon: Icon(Icons.add),
        color: SharedStyle.red,
      ),
    );
  }

  Widget quantityNum() {
    return Text(
      "$quan_of_prod",
      style: ProductStyle.quantityBarNum,
    );
  }

  Widget total() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // title
        plainTitle("Total"),
        // total amount
        totalAmount(getTotalAmount().toStringAsFixed(2))
      ],
    );
  }

  Widget title(String name, [String require = "0"]) {
    String requireName = "";
    if (name == "Sizes") {
      requireName = "1 Required";
    } else if (require == "0") {
      requireName = "Optional";
    } else {
      requireName = "$require Required";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        plainTitle(name),
        Text(
          requireName,
        ),
      ],
    );
  }

  Widget plainTitle(String name) {
    return Text(
      name,
      style: ProductStyle.title,
    );
  }

  Widget subTitle(String name, bool selected) {
    return Text(
      name,
      style: selected
          ? ProductStyle.selectedSubTitle
          : ProductStyle.unselectedSubTitle,
    );
  }

  Widget priceDisplay(double _price, double _basePrice, bool selected) {
    String _stringPrice = _price.toStringAsFixed(2);
    String _stringBasePrice = _basePrice.toStringAsFixed(2);
    bool _isSame = _price == _basePrice;

    return Row(
      children: [
        if (!_isSame) ...[
          Text(
            "₱$_stringPrice",
            style: selected
                ? ProductStyle.selectedSubTitle
                : ProductStyle.unselectedSubTitle,
          ),
          SizedBox(
            width: SharedFunction.scaleWidth(10, width),
          )
        ],
        Text(
          "₱$_stringBasePrice",
          style: selected
              ? (_isSame
                  ? ProductStyle.selectedSubTitle
                  : ProductStyle.selectedSubTitleLineThrough)
              : (_isSame
                  ? ProductStyle.unselectedSubTitle
                  : ProductStyle.unselectedSubTitleLineThrough),
        )
      ],
    );
  }

  Widget totalAmount(String _total) {
    return Text("₱$_total", style: ProductStyle.totalAmount);
  }

  double getTotalAmount() {
    // get price of size
    double _sizePrice =
        selectedSize["price"] == null ? 0 : selectedSize["price"];
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

  Widget addToBasketBtn() {
    Function() _onPressed = () async {
      // check if size has been selected
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
        "product_id": product["id"],
        "seller_id": seller["id"],
        "product_price_id": selectedSize["product_price_id"],
        "quantity": quan_of_prod,
        "add_on_ids": _addOnsIds,
      };

      String _url = "${SharedUrl.root}/${SharedUrl.version}/buyer/carts";
      Map _response = await SharedFunction.sendData(_url, _headers, _data);

      if (_response["status"] == 200) {
        Navigator.pop(context);
      } else {
        PopUp.error(context, "error in server");
      }
    };

    return SharedWidgets.redBtn(
        onPressed: _onPressed,
        name: "Add To Basket",
        width: width,
        height: height);
  }
}
