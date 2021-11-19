import 'package:flutter/material.dart';
import 'package:ryve_mobile/features/home/home.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';
import 'package:ryve_mobile/features/sign_in/sign_in_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ryve_mobile/features/sign_up/sign_up.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // data url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyers/sign_in";

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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              body: Center(
                child: Container(
                  width: SharedFunction.scaleWidth(300, width),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      title(),
                      // Space betweeen title and form
                      //SizedBox(height: SharedFunction.scaleHeight(80, height)),
                      // Form
                      form()
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget title() {
    return Text(
      "Welcome back!",
      style: SignInStyle.title,
    );
  }

  Widget form() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            // email
            email(),
            // password
            SizedBox(height: SharedFunction.scaleHeight(10, height)),
            password(),
            SizedBox(height: SharedFunction.scaleHeight(10, height)),
            // reset password
            resetPass(),
            // space
            //SizedBox(height: SharedFunction.scaleHeight(68, height)),
            // sign in button
            signInBtn(),
            SizedBox(height: SharedFunction.scaleHeight(20, height)),
            // create account
            createAcc()
          ],
        ));
  }

  Widget email() {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('Email'),
      validator: (value) {
        // check if input field is empty
        if (value!.isEmpty) {
          return "Email is required";
        }

        // check if input is valid email
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Please enter a valid email";
        }
      },
      onSaved: (value) => _email = value,
    );
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      decoration: SharedStyle.textFormFieldDecoration('Password'),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
      },
      onSaved: (value) => _password = value,
    );
  }

  Widget resetPass() {
    return TextButton(
        onPressed: () {},
        child: Text(
          "Reset Password",
          style: SharedStyle.linkText,
        ));
  }

  Widget signInBtn() {
    Function() _onPressedFunction = () async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      // start loading page
      setState(() => loading = true);
      // Save form inputs to their variables
      formKey.currentState!.save();

      // Send data to backend
      Map _data = {"email": _email, "password": _password};
      Map _response = await SharedFunction.sendData(_dataUrl, {}, _data);
      Map _responseBody = _response['body'];

      // end loading page
      setState(() => loading = false);

      if (_response['status'] == 200) {
        // successful
        // save headers
        await Headers.setHeaders(_response['headers']);
        // go to home
        Navigator.pushNamed(context, Home.routeName);
      } else if (_response['status'] == 422) {
        // doesnt have account
        PopUp.error(context, _responseBody['status']);
      } else if (_response['status'] == 401) {
        // invalid creds
        PopUp.error(context, _responseBody['errors'][0]);
      } else {
        // 500 status code
        PopUp.error(context);
      }
    };
    return SharedWidgets.redBtn(_onPressedFunction, 'Sign In', width, height);
  }

  Widget createAcc() {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, SignUp.routeName),
        child: Text(
          "Create Account",
          style: SharedStyle.linkText,
        ));
  }
}
