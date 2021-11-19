import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';
import 'package:ryve_mobile/features/sign_in/styles/sign_in_style.dart';
import 'package:ryve_mobile/features/sign_in/controllers/sign_in_controller.dart';
import 'package:ryve_mobile/features/sign_up/views/sign_up.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // data url
  //String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyers/sign_in";
  SignInController con = SignInController();
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
  // var _email;
  // var _password;

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
      validator: con.validateEmail,
      onSaved: con.saveEmail,
    );
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      decoration: SharedStyle.textFormFieldDecoration('Password'),
      validator: con.validatePassword,
      onSaved: con.savePassword,
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
    return SharedWidgets.redBtn(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }
        setState(() => loading = true);
        formKey.currentState!.save();

        var _response = await con.sendData(context);
        setState(() => loading = false);
        return _response;
      },
      name: 'Sign In',
      width: width,
      height: height,
    );
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
