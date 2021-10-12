import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/loading.dart';
import 'package:landgo_rider/sign_in/sign_in_style.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "sign_in";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // dimensions of needed in displays
  final double signInBtnWidth = 300;
  final double signInBtnHeight = 60;

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // form key
  final formKey = GlobalKey<FormState>();

  // form variables
  var _email;
  var _password;

  // loading screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :content(context);
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              // heading
              title(),
            ],
          ),
        ),
      )
    );
  }

  Widget title () {
    return Text(
      "Welcome back!",
      style: SignInStyle.title,
    );
  }
}