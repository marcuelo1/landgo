import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return PixelPerfect(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Scaffold(
            body: Text("sign in"),
          ),
        ),
      )
    );
  }
}