import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:landgo_rider/home/home_style.dart';
import 'package:landgo_rider/shared/error_page.dart';
import 'package:landgo_rider/shared/headers.dart';
import 'package:landgo_rider/shared/loading.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/shared/shared_widgets.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/rider/home";

  // dimensions
  final double btnWidth = 150;
  final double btnHeight = 30;

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  bool refresh = true;
  Map wallet = {};
  Map rider = {};

  // headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return !refresh ? buidContent(context) : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
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

            // if(responseBody['checkout_sellers'].length > 0){
            //   currentTransactions = json.decode(responseBody['checkout_sellers']);
            // }
            wallet = json.decode(responseBody['wallet']);
            rider = json.decode(responseBody['rider']);

            return buidContent(context);
        }
      }
    );
  }

  Widget buidContent(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        drawer: Drawer(
          child: SharedWidgets.sideBar(context, rider, _headers),
        ),
        backgroundColor: SharedStyle.yellow,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: SharedFunction.scaleHeight(50, height)),
              buildWallet(),
            ],
          ),
        ),
      )
    );
  }

  Widget buildWallet(){
    return Container(
      width: SharedFunction.scaleWidth(300, width),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: SharedFunction.scaleHeight(50, height)),
              buildAmountText(wallet['amount']),
              SizedBox(height: SharedFunction.scaleHeight(10, height)),
              buildText1("Balance"),
              SizedBox(height: SharedFunction.scaleHeight(50, height)),
              buildTopUpBtn(),
              SizedBox(height: SharedFunction.scaleHeight(20, height)),
              buildWithdrawBtn(),
              SizedBox(height: SharedFunction.scaleHeight(50, height)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAmountText(double _amount){
    return Text(
      "₱${_amount.toStringAsFixed(2)}",
      style: HomeStyle.amountText,
    );
  }

  Widget buildText1(String _value){
    return Text(
      _value,
      style: HomeStyle.text1
    );
  }

  Widget buildTopUpBtn(){
    return ElevatedButton(
      onPressed: (){
        print("Top Up");
      }, 
      style: SharedStyle.yellowBtn,
      child: Container(
        width: SharedFunction.scaleWidth(btnWidth, width),
        height: SharedFunction.scaleHeight(btnHeight, height),
        child: Center(
          child: Text(
            "Top Up",
            style: SharedStyle.yellowBtnText
          ),
        ),
      )
    );
  }

  Widget buildWithdrawBtn(){
    return ElevatedButton(
      onPressed: (){
        print("Withdraw");
      }, 
      style: SharedStyle.yellowBtn,
      child: Container(
        width: SharedFunction.scaleWidth(btnWidth, width),
        height: SharedFunction.scaleHeight(btnHeight, height),
        child: Center(
          child: Text(
            "Withdraw",
            style: SharedStyle.yellowBtnText
          ),
        ),
      )
    );
  }
}