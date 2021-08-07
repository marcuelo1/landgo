import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/sign_in/sign_in_style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return PixelPerfect(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(37.5, width), 
            SharedFunction.scaleHeight(226, height), 
            SharedFunction.scaleWidth(37.5, width), 
            SharedFunction.scaleHeight(48, height)
          ),
          child: Scaffold(
            body: Column(
              children: [
                // Title
                title(),
                // Space betweeen title and form
                SizedBox(height: 149),
                // Form
                form()
              ],
            ),
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

  Widget form () {
    return Text("data");
  }
}