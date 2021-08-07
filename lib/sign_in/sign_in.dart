import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/pop_up.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/sign_in/sign_in_style.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return loading ? Loading() : PixelPerfect(
      scale: scale,
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
                SizedBox(height: (130 / SharedStyle.referenceHeight) * height),
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          // email
          email(),
          // password
          password(),
          // reset password
          resetPass(),
          // space
          SizedBox(height: (68 / SharedStyle.referenceHeight) * height,),
          // sign in button
          signInBtn(),
          // create account
          createAcc()
        ],
      )
    );
  }

  Widget email () {
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

  Widget password () {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      validator: (value) {},
      onSaved: (value) => _password = value,
    );
  }

  Widget resetPass () {
    return TextButton(
      onPressed: (){}, 
      child: Text(
        "Reset Password",
        style: SignInStyle.yellowText,
      )
    );
  }

  Widget signInBtn () {
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

        // Send data to backend
        var url = Uri.parse("${SharedUrl.root}/${SharedUrl.version}/buyer_auth/sign_in");
        var response = await http.post(url, body: {"email": _email, "password": _password});
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Response header: ${response.headers}');

        // end loading page
        setState(() => loading = false);
        if(response.statusCode == 200){
          Navigator.pushNamed(context, 'home');
        }else{
          PopUp.error(context);
        }
      }, 
      child: Container(
        width: signInBtnWidth,
        height: signInBtnHeight,
        child: Center(
          child: Text(
            "Sign In",
            style: SignInStyle.signInText,
          ),
        ),
      )
    );
  }

  Widget createAcc () {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'signup'), 
      child: Text(
        "Create Account",
        style: SignInStyle.yellowText,
      )
    );
  }
}