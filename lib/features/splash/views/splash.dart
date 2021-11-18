import 'package:flutter/material.dart';
import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/network/app_url.dart';
import 'package:landgo_seller/features/pending_transactions/views/pending_transactions.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/features/sign_in/views/sign_in.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // url
  String _dataUrl = "${AppUrl.root}/${AppUrl.version}/buyer/is_signed_in";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  Map<String, String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getJson();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return FutureBuilder(
      future: HttpRequestFunction.getData(_dataUrl, _headers),
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
            width: StyleFunction.scaleWidth(234, width),
            height: StyleFunction.scaleHeight(324, height),
            child: Image.asset('images/logo_white.png')
          ),
        ),
      )
    );
  }
}