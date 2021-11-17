import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/widgets/button_widgets.dart';
import 'package:landgo_seller/core/widgets/loading.dart';
import 'package:landgo_seller/features/sign_in/controllers/sign_in_controller.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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

  // loading screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return loading ? Loading() : SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: StyleFunction.scaleWidth(300, width),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "Welcome back!",
                  style: SharedStyle.h1,
                ),
                // Space betweeen title and form
                SizedBox(height: StyleFunction.scaleHeight(80, height)),
                // Form
                _buildForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm () {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // email
          _buildEmail(),
          // password
          SizedBox(height: StyleFunction.scaleHeight(10, height)),
          _buildPassword(),
          SizedBox(height: StyleFunction.scaleHeight(10, height)),
          // reset password
          _buildResetPass(),
          // space
          SizedBox(height: StyleFunction.scaleHeight(68, height)),
          // sign in button
          _buildSignInBtn(),
          SizedBox(height: StyleFunction.scaleHeight(20, height)),
        ],
      )
    );
  }

  Widget _buildEmail () {
    return TextFormField(
      decoration: SharedStyle.textFormFieldDecoration('Email'),
      validator: con.validateEmail,
      onSaved: con.saveEmail,
    );
  }

  Widget _buildPassword () {
    return TextFormField(
      obscureText: true,
      decoration: SharedStyle.textFormFieldDecoration('Password'),
      validator: con.validatePassword,
      onSaved: con.savePassword,
    );
  }

  Widget _buildResetPass () {
    return TextButton(
      onPressed: (){}, 
      child: Text(
        "Reset Password",
        style: SharedStyle.linkText,
      )
    );
  }

  Widget _buildSignInBtn () {
    return ButtonWidgets.redBtn(
      onPressed: ()async{
        if(!formKey.currentState!.validate()){
          return;
        }
        // start loading page
        setState(() => loading = true);
        // Save form inputs to their variables
        formKey.currentState!.save();

        // Send data to backend
        var _response = await con.sendData(context); 

        // start loading page
        setState(() => loading = false);

        return _response;
      }, 
      name: 'Sign In', 
      width: width, 
      height: height
    );
  }
}