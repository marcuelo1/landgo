import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/cart/review_payment_location.dart';
import 'package:ryve_mobile/sellers/product_style.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Cart extends StatefulWidget {
  static const String routeName = "cart";
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // url
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/carts/list_of_sellers";
  String _dataUrlCartProduct ="${SharedUrl.root}/${SharedUrl.version}/buyer/carts";
  
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  static final double productHeight = 70;
  static final double productWidth = 327;
  static final double productImageWidth = 70;
  static final double productImageHeight = 70;
  final double quantityBarWidth = 100;
  final double quantityBarHeight = 35;
  final double checkoutBtnWidth = 300;
  final double checkoutBtnHeight = 60;

  // response
  Map response = {};
  Map responseBody = {};

  List sellers = [];
  Map sellerCartProducts = {};
  Map sellerTotals = {};
  List selectedSeller = [];
  Map cart_quantities = {};
  Map cart_totals = {};

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

    return responseBody.isNotEmpty
        ? content()
        : FutureBuilder(
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
                  print("==============================================================");

                  if (responseBody["sellers"].length > 0) {
                    sellers = json.decode(responseBody["sellers"]);
                  }
                  print(sellers);
                  print(
                      "==============================================================");

                  for (var seller in sellers) {
                    sellerCartProducts[seller['id']] = [];
                  }

                  return content();
              }
            });
  }

  Widget content() {
    return SafeArea(
        child: Scaffold(
      appBar: SharedWidgets.appBar(context, "Basket"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(0, height)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var seller in sellers) ...[
                _sellerContent(seller),
                if (selectedSeller.contains(seller['id'])) ...[
                  checkoutDetails(seller['id'])
                ]
              ],
              if (selectedSeller.length > 0) ... [
                checkoutBtn()
              ]
            ],
          ),
        ),
      ),
    ));
  }

  Widget _sellerContent(Map seller) {
    return GestureDetector(
      onTap: () async {
        if (sellerCartProducts[seller['id']].isEmpty) {
          String _rawUrl = _dataUrlCartProduct + "?seller_id=${seller['id']}";
          Map _response =
              await SharedFunction.getData(_rawUrl, _headers);

          if (_response['status'] == 200) {
            if (_response['body']['carts'].length > 0) {
              sellerCartProducts[seller['id']] =
                  json.decode(_response['body']['carts']);
            }
          }
        }

        setState(() {
          if (selectedSeller.contains(seller['id'])) {
            selectedSeller.remove(seller['id']);
          } else {
            selectedSeller.add(seller['id']);
          }
        });
      },
      child: SharedWidgets.seller(seller, width, height),
    );
  }

  Widget checkoutDetails(int seller_id) {
    List _carts = sellerCartProducts[seller_id];
    print(_carts);
    print("============================================");
    return Column(
      children: [
        // products
        for (var _cart in _carts) ...[cartProduct(_cart)],
        // total
        sellerTotal(_carts, seller_id)
      ],
    );
  }

  Widget cartProduct(Map _cart) {
    if(cart_quantities[_cart['id']] == null){
      cart_quantities[_cart['id']] = _cart['quantity'];
    }
    if(cart_totals[_cart['id']] == null){
      cart_totals[_cart['id']] = _cart['total'];
    }
    
    Map product = json.decode(_cart['product']);
    return Column(
      children: [
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // product
        _productContent(_cart, product),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
      ],
    );
  }

  Widget _productContent(Map _cart, Map product) {
    String imageUrl = product['image'];
    String name = product['name'];
    String price = product['price'].toStringAsFixed(2);
    String cartProductDescription = _cart['product_description'];
    String total = cart_totals[_cart['id']].toStringAsFixed(2);
    
    return Container(
      height: SharedFunction.scaleHeight(productHeight, height),
      width: SharedFunction.scaleWidth(productWidth, width),
      child: Row(
        children: [
          // quantity
          quantityBar(_cart),
          // space
          SizedBox(width: SharedFunction.scaleWidth(10, width),),
          // product details
          _productDetails(name, price, cartProductDescription),
          // add button
          _productPrice(total)
        ],
      ),
    );
  }

  Widget productImage(String url) {
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _productDetails(String name, String price, String cartProuctDescription) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product name
        _productName(name),
        // product price
        _productDescription(cartProuctDescription)
      ],
    );
  }

  Widget _productName(String name) {
    return Text(
      name,
      style: SharedStyle.productName,
    );
  }

  Widget _productPrice(String price) {
    return Text(
      "₱$price",
      style: SharedStyle.productPrice,
    );
  }

  Widget _productDescription(String descrip) {
    return Container(
      width: SharedFunction.scaleWidth(150, width),
      child: Text(
        descrip,
        overflow: TextOverflow.ellipsis,
        style: SharedStyle.productPrice,
      ),
    );
  }

  Widget quantityBar(Map _cart) {
    return Container(
      width: SharedFunction.scaleWidth(quantityBarWidth, width),
      height: SharedFunction.scaleHeight(quantityBarHeight, height),
      decoration: ProductStyle.quantityBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          quantityMinus(_cart), 
          quantityNum(_cart), 
          quantityAdd(_cart)
        ],
      ),
    );
  }

  Widget quantityMinus(Map _cart) {
    return Center(
      child: IconButton(
        onPressed: () async {
          if (cart_quantities[_cart['id']] > 1) {
            setState(() {
              var cartPrice = cart_totals[_cart['id']] / cart_quantities[_cart['id']];
              cart_quantities[_cart['id']]--;
              cart_totals[_cart['id']] = cartPrice * cart_quantities[_cart['id']];
            });
            String _rawUrl = _dataUrlCartProduct + "/${_cart['id']}";
            Map _data = {
              "quantity": cart_quantities[_cart['id']],
              "total": cart_totals[_cart['id']],
            };
            var response = SharedFunction.sendData(_rawUrl, _headers, _data, "put");
          }
        },
        icon: Icon(
          Icons.remove,
        ),
        color: SharedStyle.yellow,
      ),
    );
  }

  Widget quantityAdd(Map _cart) {
    return Center(
      child: IconButton(
        onPressed: () {
          setState(() {
            var cartPrice = cart_totals[_cart['id']] / cart_quantities[_cart['id']];
            cart_quantities[_cart['id']]++;
            cart_totals[_cart['id']] = cartPrice * cart_quantities[_cart['id']];
          });
          String _rawUrl = _dataUrlCartProduct + "/${_cart['id']}";
          Map _data ={
            "quantity": cart_quantities[_cart['id']],
            "total": cart_totals[_cart['id']],
          };
          var response = SharedFunction.sendData(_rawUrl, _headers, _data, "put");
        },
        icon: Icon(Icons.add),
        color: SharedStyle.yellow,
      ),
    );
  }

  Widget quantityNum(Map _cart) {
    return Text(
      "${cart_quantities[_cart['id']]}",
      style: ProductStyle.quantityBarNum,
    );
  }

  Widget sellerTotal(List _carts, int sellerId){
    double _totalPrice = 0;
    
    for (var _cart in _carts) {
      if(cart_totals[_cart['id']] != null){
        _totalPrice += cart_totals[_cart['id']];
      }
    }

    sellerTotals[sellerId] = _totalPrice;
    String _totalPriceString = _totalPrice.toStringAsFixed(2);
    print(_totalPriceString);
    print("===================================");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total", style: SharedStyle.subTitle,),
        Text("₱$_totalPriceString", style: SharedStyle.subTitleYellow,)
      ],
    );
  }

  Widget checkoutBtn(){
    double _totalPrice = 0;
    sellerTotals.forEach((key, value) {
      if(selectedSeller.contains(key)){
        _totalPrice += value;
      }
    });

    return ElevatedButton(
      onPressed: () async {
        // send data for checkout
        Map rawBody = {
          "sellers": selectedSeller
        };
        
        Navigator.pushNamed(context, ReviewPaymentLocation.routeName, arguments: rawBody);
      }, 
      style: SharedStyle.yellowBtn,
      child: Container(
        width: SharedFunction.scaleWidth(checkoutBtnWidth, width),
        height: SharedFunction.scaleHeight(checkoutBtnHeight, height),
        child: Center(
          child: Text("Checkout $_totalPrice", style: SharedStyle.yellowBtnText,),
        ),
      )
    );
  }
}
