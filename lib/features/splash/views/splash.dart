import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/network/app_url.dart';
import 'package:landgo_seller/features/pending_transactions/views/pending_transactions.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/features/sign_in/views/sign_in.dart';
import 'package:landgo_seller/features/splash/controllers/splash_controller.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  SplashController con = SplashController();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // delay for 2 seconds
      await Future.delayed(const Duration(milliseconds: 2000));
      // check if user is logged in
      if(con.isLoggedIn()){
        Navigator.popAndPushNamed(context, PendingTransactions.routeName);
      }else{
        Navigator.popAndPushNamed(context, SignIn.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

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