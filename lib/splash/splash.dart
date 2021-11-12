import 'package:flutter/material.dart';
import 'package:landgo_seller/pending%20transacstions/pending_transactions.dart';
import 'package:landgo_seller/shared/headers.dart';
import 'package:landgo_seller/shared/shared_function.dart';
import 'package:landgo_seller/shared/shared_style.dart';
import 'package:landgo_seller/shared/shared_url.dart';
import 'package:landgo_seller/sign_in/sign_in.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/is_signed_in";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

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

    return FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("check internet");
          case ConnectionState.waiting: // Retrieving
            return content(context);
          default: // Success of connecting to back end
            var response = snapshot.data;
            print(response);
            print("====================");
            // check status of response
            if (response['status'] == 200) {
              return PendingTransactions();
            } else {
              return SignIn();
            }
            // return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: SharedStyle.white,
        body: Center(
          child: Container(
            width: SharedFunction.scaleWidth(234, width),
            height: SharedFunction.scaleHeight(324, height),
            child: Image.asset('images/logo_white.png')
          ),
        ),
      )
    );
  }
}