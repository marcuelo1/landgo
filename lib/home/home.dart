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
  String _deliveredUrl = "${SharedUrl.root}/${SharedUrl.version}/rider/delivered";

  // dimensions
  final double btnWidth = 150;
  final double btnHeight = 30;

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  bool refresh = true;
  Map rider = {};
  Map transaction = {};

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
            
            rider = responseBody['rider'];
            transaction = responseBody['current_transaction'];

            return buidContent(context);
        }
      }
    );
  }

  Widget buidContent(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        bottomNavigationBar: SharedWidgets.bottomAppBar(context),
        drawer: Drawer(
          child: SharedWidgets.sideBar(context, rider, _headers),
        ),
        backgroundColor: SharedStyle.yellow,
        body: Center(
          child: transaction.isEmpty ? Text("No Pending Transaction") : buildTransactionContainer(),
        ),
      )
    );
  }

  Widget buildTransactionContainer(){
    return Container(
      color: SharedStyle.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seller name
          buildContentLabel("Seller's Name"),
          buildContentValue("${transaction['seller_name']}"),
          // Seller address
          buildContentLabel("Seller's Addrees"),
          buildContentValue("${transaction['seller_address']}"),
          // Buyer name
          buildContentLabel("Buyer's Name"),
          buildContentValue("${transaction['buyer_name']}"),
          // Buyer address
          buildContentLabel("Buyer's Address"),
          buildContentValue("${transaction['buyer_address']}"),
          // Buyer delivery fee
          buildContentLabel("Buyer's Delivery Fee"),
          buildContentValue("${transaction['buyer_delivery_fee']}"),
          // Rider delivery fee
          buildContentLabel("Rider's Delivery Fee"),
          buildContentValue("${transaction['rider_delivery_fee']}"),
          // Delivered button
          buildDeliveredBtn()
        ],
      ),
    );
  }

  Widget buildContentLabel(String _label){
    return Text(
      _label,
      style: SharedStyle.labelBold
    );
  }

  Widget buildContentValue(String _value){
    return Text(
      _value,
      style: SharedStyle.labelRegular
    );
  }

  Widget buildDeliveredBtn(){
    return ElevatedButton(
      onPressed: () async{
        Map _data = {
          "transaction_id": transaction['id']
        };
        Map _response = await SharedFunction.sendData(_deliveredUrl, _headers, _data);
        
        if(_response['status'] == 200){
          setState(() {
            transaction = {};
          });
        }
      }, 
      child: Text("Delivered")
    );
  }
}