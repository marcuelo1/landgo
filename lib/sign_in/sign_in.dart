import 'package:flutter/material.dart';
import 'package:landgo_rider/home/home.dart';
import 'package:landgo_rider/shared/headers.dart';
import 'package:landgo_rider/shared/loading.dart';
import 'package:landgo_rider/shared/pop_up.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/sign_in/sign_in_style.dart';

class SignIn extends StatefulWidget {
  static const String routeName = "sign_in";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/riders/sign_in";

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

    return loading ? Loading() : content(context);
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // heading
              title(),
              // Space betweeen title and form
              SizedBox(height: (80 / SharedStyle.referenceHeight) * height),
              // form
              form()
            ],
          ),
        ),
      )
    );
  }

  Widget title(){
    return Text(
      "Welcome back!",
      style: SignInStyle.title,
    );
  }

  Widget form(){
    return Form(
      key: formKey,
      child: Container(
        width: SharedFunction.scaleWidth(300, width),
        child: Column(
          children: [
            email(),
            password(),
            SizedBox(height: SharedFunction.scaleHeight(68, height),),
            signInBtn()
          ],
        ),
      )
    );
  }

  Widget email(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      validator: (value){
        // check if input field is empty
        if(value!.isEmpty){
          return "Email is required";
        }

        // check if input is valid email
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
          return "Please enter a valid email";
        }
      },
      onSaved: (value) => _email = value,
    );
  }
  
  Widget password(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      validator: (value) {
        if(value!.isEmpty){
          return "Password is required";
        }
      },
      onSaved: (value) => _password = value,
    );
  }

  Widget signInBtn(){
    return ElevatedButton(
      style: SignInStyle.signInBtn,
      onPressed: () async {
        if(!formKey.currentState!.validate()){
          return;
        }
        // start loading page
        setState(() => loading = true);
        // Save form inputs to their variables
        formKey.currentState!.save();

        Map _data = {
          "email": _email, 
          "password": _password
        };

        // Send data to backend
        Map _response = await SharedFunction.sendData(_dataUrl, {}, _data);
        Map _responseBody = _response['body'];

        // end loading page
        setState(() => loading = false);
        
        switch (_response['status']) {
          case 200:
            // save headers
            await Headers.setHeaders(_response['headers']);
            // go to home
            Navigator.popAndPushNamed(context, Home.routeName);
            break;
          case 401:
            PopUp.error(context, _responseBody['errors'][0]);
            break;
          default:
            PopUp.error(context);
        }
      }, 
      child: Container(
        width: SharedFunction.scaleWidth(signInBtnWidth, width),
        height: SharedFunction.scaleHeight(signInBtnHeight, height),
        child: Center(
          child: Text(
            "Sign In",
            style: SignInStyle.signInText,
          ),
        ),
      )
    );
  }
}