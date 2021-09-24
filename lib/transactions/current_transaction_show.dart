import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/error_page.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class CurrentTransactionShow extends StatefulWidget {
  static const String routeName = "current_transaction_show";

  @override
  _CurrentTransactionShowState createState() => _CurrentTransactionShowState();
}

class _CurrentTransactionShowState extends State<CurrentTransactionShow> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts/";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double statusContainerHeight = 300;

  // variables
  Map currentTransaction = {};
  bool refresh = true;
  List carts = [];
  String buyerAddress = "";

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
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    currentTransaction = args['checkout_seller'];

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    String rawUrl = _dataUrl + "${currentTransaction['seller_id']}";

    return !refresh ? content(context) : FutureBuilder(
      future: SharedFunction.getData(rawUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ErrorPage();
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if (snapshot.hasError) {
              return  ErrorPage();
            }
            refresh = false;

            // get response
            var response = snapshot.data;
            var responseBody = response['body'];
            print(responseBody);
            print("============================================================== response body");

            if(responseBody['carts'].length > 0){
              carts = json.decode(responseBody['carts']);
            }
            print(carts);
            print("============================================================== carts");

            buyerAddress = responseBody['buyer_address'];

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              statusContainer(),
              orderContainer()
            ],
          ),
        ),
      )
    );
  }

  Widget statusContainer(){
    return Container(
      width: double.infinity,
      height: SharedFunction.scaleHeight(statusContainerHeight, height),
      child: Center(
        child: Text(currentTransaction['status']),
      ),
    );
  }

  Widget orderContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cardTitle("Order Details"),
        SizedBox(height: SharedFunction.scaleHeight(10, height),),
        sellerDetails("You order from:", currentTransaction['seller_name']),
        SizedBox(height: SharedFunction.scaleHeight(5, height),),
        sellerDetails("Delivery Address:", buyerAddress),

        Divider(color: SharedStyle.black,height: 1,),

        for (var _cart in carts) ... [
          cartContainer(_cart),
          SizedBox(height: SharedFunction.scaleHeight(5, height),),
        ],

        Divider(color: SharedStyle.black,height: 1,),
        cardTitle("Total", "₱${currentTransaction['total'].toStringAsFixed(2)}"),
        Divider(color: SharedStyle.black,height: 1,),

      ],
    );
  }

  Widget cardTitle(String _name, [String _price = ""]){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_name),
        if(_price != "") ... [
          Text(_price),
        ]
      ],
    );
  }

  Widget sellerDetails(String _label, String _value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_label),
        Text(_value),
      ],
    );
  }

  Widget cardLabel(String _name){
    return Text(_name);
  }

  Widget cartContainer(Map _cart){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        cartQuantity(_cart),
        cartDetails(_cart),
        cardPrice(_cart)
      ],
    );
  }

  Widget cartQuantity(Map _cart){
    return Text(
      "${_cart['quantity']}x "
    );
  }

  Widget cartDetails(Map _cart){
    Map _product = json.decode(_cart['product']);

    return Column(
      children: [
        Text(_product['name']),
        Text(_cart['product_description'])
      ],
    );
  }

  Widget cardPrice(Map _cart){
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Text("₱${_cart['total'].toStringAsFixed(2)}"),
      )
    );
  }
}