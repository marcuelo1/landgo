import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/core/widgets/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';
import 'package:ryve_mobile/features/sign_in/views/sign_in.dart';
import 'package:ryve_mobile/features/sign_up/controllers/sign_up_controller.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  static const String routeName = "signup";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController con = SignUpController();
  // dimensions of needed in displays
  final double signUpBtnWidth = 300;
  final double signUpBtnHeight = 60;
  final double navBtnWidth = 300;
  final double navUpBtnHeight = 60;

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // form key
  final formKey = GlobalKey<FormState>();

  // Page and variable for values of the form
  // var _email;
  // var _password;
  // var _confirmPassword;
  // var _firstName;
  // var _lastName;
  // var _mobileNumber;

  bool isChecked = false;
  bool loading = false;

  // Controllers
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController mobileNumberCon = TextEditingController();

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Space
                        SizedBox(
                          height: SharedFunction.scaleHeight(50, height),
                        ),

                        /// TITLE
                        title(),
                        // Space
                        SizedBox(
                          height: SharedFunction.scaleHeight(20, height),
                        ),

                        /// FORM
                        form(),
                        // Space
                        SizedBox(
                          height: SharedFunction.scaleHeight(20, height),
                        ),

                        /// Already registered
                        signIn()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget title() {
    return Text(
      "Let's get started",
      style: SharedStyle.h1,
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          /// First Name
          firstName(),

          /// Last Name
          lastName(),

          /// Confirm Password
          mobileNumber(),

          /// Email
          email(),

          /// Password
          password(),

          /// Confirm Password
          confirmPassword(),
          // space
          SizedBox(
            height: SharedFunction.scaleHeight(30, height),
          ),
          // terms and policy
          termsAndPolicyContainer(),
          // Space
          SizedBox(
            height: SharedFunction.scaleHeight(50, height),
          ),

          /// sign up
          signUp()
        ],
      ),
    );
  }

  Widget email() {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('Email'),
      controller: emailCon,
      validator: con.validateEmail,
      onSaved: con.saveEmail,
    );
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      decoration: SharedStyle.textFormFieldDecoration('Password'),
      controller: passwordCon,
      validator: con.validatePassword,
      onSaved: con.savePassword,
    );
  }

  Widget confirmPassword() {
    return TextFormField(
      obscureText: true,
      decoration: SharedStyle.textFormFieldDecoration('Confirm Password'),
      controller: confirmPasswordCon,
      validator: con.validateConfirmPassword,
      onSaved: con.saveConfirmPassword,
    );
  }

  Widget firstName() {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('First Name'),
      controller: firstNameCon,
      validator: con.validateFirstname,
      onSaved: con.saveFirstName,
    );
  }

  Widget lastName() {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('Last Name'),
      controller: lastNameCon,
      validator: con.validateLastName,
      onSaved: con.saveLastName,
    );
  }

  Widget mobileNumber() {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('Mobile Number'),
      controller: mobileNumberCon,
      validator: con.validateMobileNumber,
      onSaved: con.saveMoblieNumber,
    );
  }

  Widget termsAndPolicyContainer() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Checkbox(
          checkColor: SharedStyle.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Expanded(
          child: Wrap(
            children: [
              Text("I agree with the ", style: SharedStyle.regularText),
              InkWell(
                  onTap: () {
                    print("object");
                  },
                  child: Text(
                    "Terms of Conditions",
                    style: SharedStyle.redRegularText,
                  )),
              Text(" and ", style: SharedStyle.regularText),
              InkWell(
                  onTap: () {
                    print("object2");
                  },
                  child: Text("Privacy and Policy",
                      style: SharedStyle.redRegularText)),
            ],
          ),
        )
      ],
    );
  }

  Widget signUp() {
    return SharedWidgets.redBtn(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }
          setState(() {
            loading = true;
          });
          formKey.currentState!.save();
          var _response = await con.sendData(context);
          setState(() => loading = false);
          return _response;
        },
        name: 'Sign Up',
        width: width,
        height: height);
  }

  Widget signIn() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, SignIn.routeName);
        },
        child: Text(
          "Sign in.",
          style: SharedStyle.linkText,
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    return SharedStyle.red;
  }
}
