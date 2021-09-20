import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ReviewPaymentLocation extends StatefulWidget {
  static const String routeName = "review_payment_location";

  @override
  _ReviewPaymentLocationState createState() => _ReviewPaymentLocationState();
}

class _ReviewPaymentLocationState extends State<ReviewPaymentLocation> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/review_payment_location";
  String _dataUrlCheckout ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts";
  
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  static final double cardHeight = 100;
  static final double cardWidth = 327;

  // variables
  Map checkoutData = {};
  List locations = [];
  List paymentMethods = [];
  bool refresh = true;
  bool changeLocation = false;

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
    args.forEach((key, value) {
      checkoutData[key] = value;
    });

    return !refresh ? content() : FutureBuilder(
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
            var response = snapshot.data;
            var responseBody = response['body'];
            print(responseBody);
            print("==============================================================");

            if(responseBody['locations'].length > 0){
              locations = json.decode(responseBody["locations"]);
            }

            if(responseBody['payment_methods'].length > 0){
              paymentMethods = json.decode(responseBody["payment_methods"]);
            }

            return content();
        }
      }
    );
  }

  Widget content(){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        backgroundColor: SharedStyle.yellow,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(0, height)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              locationContainer(),
              SizedBox(height: SharedFunction.scaleHeight(20, height),),
              paymentMethodContainer(),
            ],
          ),
        )
      )
    );
  }

  Widget locationContainer(){
    return Container(
      width: SharedFunction.scaleWidth(cardWidth, width),
      height: SharedFunction.scaleHeight(cardHeight, height),
      color: SharedStyle.white,
      child: Column(
        children: [
          cardHeader(Icon(Icons.location_on_outlined), "Delivery Location"),
          SizedBox(height: SharedFunction.scaleHeight(10, height),),
          if(!changeLocation) ... [
            for (var _location in locations) ... [
              if(_location['selected']) ... [
                selectedLocation(_location)
              ]
            ]
          ]
        ],
      ),
    );
  }

  Widget paymentMethodContainer(){
    return Container(
      width: SharedFunction.scaleWidth(cardWidth, width),
      height: SharedFunction.scaleHeight(cardHeight, height),
      color: SharedStyle.white,
      child: Column(
        children: [
          cardHeader(Icon(Icons.account_balance_wallet_outlined), "Payment Method"),
          SizedBox(height: SharedFunction.scaleHeight(10, height),),
          for (var _paymentMethod in paymentMethods) ... [
            selectedPaymentMethod(_paymentMethod)
          ]
        ],
      ),
    );
  }

  Widget cardHeader(Icon icon, String name){
    return Row(
      children: [
        icon,
        cardHeaderName(name),
        editBtn()
      ],
    );
  }

  Widget cardHeaderName(String name){
    return Text(
      name
    );
  }

  Widget editBtn(){
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.edit,
        ),
      )
    );
  }

  Widget selectedLocation(Map _location){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(_location['name'])
      ],
    );
  }

  Widget selectedPaymentMethod(Map _paymentMethod){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(_paymentMethod['name'])
      ],
    );
  }
  
}