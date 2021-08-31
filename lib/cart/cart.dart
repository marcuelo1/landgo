import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
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
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/carts/list_of_sellers";
  String _dataUrlCartProduct = "${SharedUrl.root}/${SharedUrl.version}/buyer/carts";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // response
  Map response = {};
  Map responseBody = {};

  List sellers = [];
  Map sellerCartProducts = {};
  int selectedSeller = 0;

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

    return responseBody.isNotEmpty ? content() : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("check internet");
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if(snapshot.hasError){
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
            print("==============================================================");

            for (var seller in sellers) {
              sellerCartProducts[seller['id']] = [];
            }

            return content();
        }
      }
    );
  }

  Widget content(){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, "Basket"),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width), 
            SharedFunction.scaleHeight(20, height), 
            SharedFunction.scaleWidth(24, width), 
            SharedFunction.scaleHeight(0, height)
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var seller in sellers) ... [
                  _sellerContent(seller),
                  if(selectedSeller == seller['id']) ... [
                    checkoutDetails()
                  ]
                ]
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _sellerContent(Map seller){
    return GestureDetector(
      onTap: () async {
        if(sellerCartProducts[seller['id']].isEmpty){
          _dataUrlCartProduct += "?seller_id=${seller['id']}";
          Map _response = await SharedFunction.getData(_dataUrlCartProduct, _headers);

          if (_response['status'] == 200){
            if(_response['body']['carts'].length > 0) {
              sellerCartProducts[seller['id']] = json.decode(_response['body']['carts']);
            }
          }
        }

        setState(() {
          selectedSeller = seller['id'];
        });
      },
      child: SharedWidgets.seller(seller, width, height),
    );
  }

  Widget checkoutDetails(){
    List _products = sellerCartProducts[selectedSeller];
    return Column(
      children: [
        // products
      ],
    );
  }
}