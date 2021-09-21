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
  String _selectAddressUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/locations/select_location";
  String _selectPaymentUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/payment_methods/select_payment_method";
  String _dataUrlCheckout ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts";
  
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  static final double cardHeight = 150;
  static final double cardWidth = 327;

  // variables
  Map checkoutData = {};
  List locations = [];
  List paymentMethods = [];
  bool refresh = true;
  bool changeLocation = false;
  bool changePayment = false;
  int selectedPayment = 0;

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
            refresh = false;

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

            selectedPayment = responseBody["selected_payment_method"];

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
          ]else ... [
            locationList()
          ]
        ],
      ),
    );
  }

  Widget paymentMethodContainer(){
    return Container(
      width: SharedFunction.scaleWidth(cardWidth, width),
      color: SharedStyle.white,
      child: Column(
        children: [
          cardHeader(Icon(Icons.account_balance_wallet_outlined), "Payment Method"),
          SizedBox(height: SharedFunction.scaleHeight(10, height),),
          if(!changePayment) ... [
            for (var _paymentMethod in paymentMethods) ... [
              if(_paymentMethod['id'] == selectedPayment) ... [
                selectedPaymentMethod(_paymentMethod)
              ]
            ]
          ]else ... [
            paymentMethodList()
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
        editBtn(name)
      ],
    );
  }

  Widget cardHeaderName(String name){
    return Text(
      name
    );
  }

  Widget editBtn(String name){
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            if(name == "Payment Method"){
              setState(() => changePayment = true);
            }else{
              setState(() => changeLocation = true);
            }
          },
          icon: Icon(
            Icons.edit,
          ),
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

  Widget locationList(){
    return Container(
      height: SharedFunction.scaleHeight(100, height),
      child: ListView(
        children: [
          for (var _location in locations) ... [
            ListTile(
              onTap: () async {
                var _response = await SharedFunction.sendData(_selectAddressUrl, _headers, {"id": _location['id']});

                if (_response['status'] == 200){
                  setState(() {
                    if(_response['body']['locations'].length > 0){
                      locations = json.decode(_response['body']['locations']);
                    }
                    changeLocation = false;
                  });

                  print(locations);
                }
              },
              title: Container(
                color: _location['selected'] ? SharedStyle.yellow : SharedStyle.white,
                child: location(_location),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget paymentMethodList(){
    return Container(
      height: SharedFunction.scaleHeight(100, height),
      child: ListView(
        children: [
          for (var _paymentMethod in paymentMethods) ... [
            ListTile(
              onTap: () async {
                var _response = await SharedFunction.sendData(_selectPaymentUrl, _headers, {"id": _paymentMethod['id']});

                if (_response['status'] == 200){
                  setState(() {
                    selectedPayment = _paymentMethod['id'];
                    changePayment = false;
                  });
                }
              },
              title: Container(
                color: _paymentMethod['id'] == selectedPayment ? SharedStyle.yellow : SharedStyle.white,
                child: paymentMethod(_paymentMethod),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget location(Map _location){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(_location['name'])
      ],
    );
  }

  Widget paymentMethod(Map _paymentMethod){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(_paymentMethod['name'])
      ],
    );
  }
  
}