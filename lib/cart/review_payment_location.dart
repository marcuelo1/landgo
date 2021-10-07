import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';
import 'package:ryve_mobile/transactions/current_transactions.dart';

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
  Map argsData = {};
  List locations = [];
  List paymentMethods = [];
  bool refresh = true;
  bool changeLocation = false;
  bool changePayment = false;
  int selectedPaymentId = 0;
  int selectedLocationId = 0;

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
      argsData[key] = value;
    });

    String rawUrl = _dataUrl + "?seller_ids=${argsData['sellers'].join(',')}";

    return !refresh ? content() : FutureBuilder(
      future: SharedFunction.getData(rawUrl, _headers),
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
            print("============================================================== response body");

            if(responseBody['locations'].length > 0){
              locations = json.decode(responseBody["locations"]);
            }
            print("============================================================== locations");

            selectedLocationId = responseBody["selected_location_id"];

            if(responseBody['payment_methods'].length > 0){
              paymentMethods = json.decode(responseBody["payment_methods"]);
            }
            print("============================================================== payment methods");

            selectedPaymentId = responseBody["selected_payment_method_id"];
            print("============================================================== selected payment method");

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
              SizedBox(height: SharedFunction.scaleHeight(20, height),),
              orderSummaryContainer(),
              SizedBox(height: SharedFunction.scaleHeight(20, height),),
              placeOrderBtn()
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
              if(_paymentMethod['id'] == selectedPaymentId) ... [
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

  Widget orderSummaryContainer(){
    print("================================= orderSummaryContainer");
    return Container(
      width: SharedFunction.scaleWidth(cardWidth, width),
      color: SharedStyle.white,
      child: Column(
        children: [
          cardHeader(Icon(Icons.receipt), "Order summary", false),
          SizedBox(height: SharedFunction.scaleHeight(10, height),),
          for (var _seller in argsData["sellers"]) ... [
            orderSummaryContent(_seller, argsData["sellerCartProducts"][_seller['id']]),
            SizedBox(height: SharedFunction.scaleHeight(10, height),),
          ]
        ],
      ),
    );
  }

  Widget cardHeader(Icon icon, String name, [bool showEdit = true]){
    return Row(
      children: [
        icon,
        cardHeaderName(name),
        if (showEdit) ... [
          editBtn(name)
        ]
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
                    selectedLocationId =  _location['id'];
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
                    selectedPaymentId = _paymentMethod['id'];
                    changePayment = false;
                  });
                }
              },
              title: Container(
                color: _paymentMethod['id'] == selectedPaymentId ? SharedStyle.yellow : SharedStyle.white,
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

  Widget orderSummaryContent(Map _seller, List _carts){
    print("================================= orderSummaryContent");

    double _vat = argsData['sellerSubTotals'][_seller['id']] * .2;
    double _voucherAmount = 0;

    for (var _voucherRaw in argsData['selectedVouchers']) {
      if(_voucherRaw['seller_id'] == _seller['id']){
        _voucherAmount = _voucherRaw['discount_amount'];
        break;
      }
    }

    return Column(
      children: [
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        orderSummarySeller(_seller),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        for (var _cart in _carts) ... [
          orderSummaryItems(_cart),
          SizedBox(height: SharedFunction.scaleHeight(5, height)),
        ],
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        rowWithValue('Sub Total', argsData['sellerSubTotals'][_seller['id']]),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        rowWithValue('Delivery Fee', argsData['deliveryFees'][_seller['id'].toString()]),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        rowWithValue('VAT', _vat),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        rowWithValue('Voucher', _voucherAmount),
        SizedBox(height: SharedFunction.scaleHeight(5, height)),
        rowWithValue('Total', argsData['sellerTotals'][_seller['id']]),
      ],
    );
  }

  Widget orderSummarySeller(Map _seller){
    print("================================= orderSummarySeller");
    return Row(
      children: [
        Text("Store: ", style: SharedStyle.labelBold),
        Text(_seller['name'], style: SharedStyle.labelBold)
      ],
    );
  }

  Widget orderSummaryItems(Map _cart){
    print("================================= orderSummaryItems");
    Map _product = json.decode(_cart['product']);

    return Row(
      children: [
        orderItemQuantity(_cart['quantity']),
        orderItemContent(_product['name'], _cart['product_description']),
        orderItemTotal(_cart['total'])
      ],
    );
  }

  Widget orderItemQuantity(double _quantity){
    return Text("${_quantity.toString()}x", style: SharedStyle.labelRegular,);
  }

  Widget orderItemContent(String _name, String _description){
    return Expanded(
      child: Column(
        children: [
          Text(_name, style: SharedStyle.labelRegular),
          Text(_description, style: SharedStyle.labelRegular)
        ],
      ),
    );
  }

  Widget orderItemTotal(double _total){
    return Text("₱${_total.toStringAsFixed(2)}", style: SharedStyle.labelRegular);
  }

  Widget placeOrderBtn(){
    return ElevatedButton(
      onPressed: () async {
        Map checkoutData = {
          "sellers": argsData["sellers"],
          "selectedVouchers": argsData["selectedVouchers"],
          "deliveryFees": argsData['deliveryFees'],
          "location_id": selectedLocationId,
          "payment_method_id": selectedPaymentId,
        };
        
        Map _response = await SharedFunction.sendData(_dataUrlCheckout, _headers, checkoutData);
        if(_response['status'] == 200){
          Navigator.pushNamed(context, CurrentTransactions.routeName);
        }
      }, 
      style: SharedStyle.yellowBtn,
      child: Center(
        child: Text(
          "Place Order",
          style: SharedStyle.yellowBtnText,
        ),
      )
    );
  }
  
  Widget rowWithValue(String _name, double _value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_name, style: SharedStyle.labelRegular,),
        Text("₱${_value.toStringAsFixed(2)}", style: SharedStyle.labelRegular,),
      ],
    );
  }
}