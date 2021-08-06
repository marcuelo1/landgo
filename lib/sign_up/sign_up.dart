import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/sign_up/sign_up_style.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  int currentPage = 1;
  var _email;
  var _password;
  var _confirmPassword;
  var _firstName;
  var _lastName;
  var _mobileNumber;

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
    List<Widget> page = <Widget>[];

    switch (currentPage) {
      case 1:
        page = [
          /// TITLE
          title(),
          /// FORM
          form_1(),
        ];
        break;
      case 2:
        page = [
          /// TITLE
          title(),
          /// FORM
          form_2(),
        ];
        break;
    }

    return loading ? Loading() : PixelPerfect(
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
              children: page,
            ),
          ),
        ),
      )
    );
  }

  Widget title(){
    return Text(
      "Let's get started",
      style: SignUpStyle.title,
    );
  }

  Widget form_1(){
    return Form(
      key: formKey,
      child: Column(
        children: [
          /// Email
          email(),
          /// Password
          password(),
          /// Confirm Password
          confirmPassword(),
          /// Next Button
          nextBtn()
        ],
      ),
    );
  }

  Widget form_2(){
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
          /// Sign Up Button
          signUp(),
          /// Back Button
          backBtn()
        ],
      ),
    );
  }

  Widget email(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      controller: emailCon,
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
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget password(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      controller: passwordCon,
      validator: (value){
        // check if input field is empty
        if(value!.isEmpty){
          return "Password is required";
        }

        _password = value;
      },
      onSaved: (value) {
        _password = value;
      },
    );
  }

  Widget confirmPassword(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Confirm Password"),
      controller: confirmPasswordCon,
      validator: (value){
        // check if input field is empty
        if(value!.isEmpty){
          return "Confirm Password is required";
        }
        // check if password and confirm password is the same
        if(value != _password){
          return "Confirm Password is not same with Password";
        }
      },
      onSaved: (value) {
        _confirmPassword = value;
      },
    );
  }

  Widget firstName(){
    return TextFormField(
      decoration: InputDecoration(labelText: "First Name"),
      controller: firstNameCon,
      validator: (value) {
        if(value!.isEmpty){
          return "First Name is required";
        }
      },
      onSaved: (value) {
        _firstName = value;
      },
    );
  }

  Widget lastName(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Last Name"),
      controller: lastNameCon,
      validator: (value) {
        if(value!.isEmpty){
          return "Last Name is required";
        }
      },
      onSaved: (value) {
        _lastName = value;
      },
    );
  }

  Widget mobileNumber(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Mobile Number"),
      controller: mobileNumberCon,
      validator: (value) {
        int? check = int.tryParse(value!);
        // check if empty or not numeric
        if(check == null){
          return "Please put valid mobile number";
        }

        // check if it has 10 numbers
        if(value.length < 10){
          return "Please put 10 digit mobile number";
        }
      },
      onSaved: (value) {
        _mobileNumber = value;
      },
    );
  }

  Widget signUp(){
    return TextButton(
      onPressed: () async { 
        if(!formKey.currentState!.validate()){
          return;
        }

        setState(() {
          loading = true;
        });
        formKey.currentState!.save();

        // Sends data to back end
        var url = Uri.parse('http://localhost:3000/v1/buyer_auth');
        var response = await http.post(
          url, 
          body: {
            "email": _email,
            "password": _password,
            "first_name": _firstName,
            "last_name": _lastName,
            "phone_number": _mobileNumber
          }
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Response header: ${response.headers}');

        if(response.statusCode == 200){
          setState(() {
            loading = false;
          });
        }
      },
      child: Container(
        width: signUpBtnWidth,
        height: signUpBtnHeight,
        margin: EdgeInsets.only(top: 13, bottom: 11),
        decoration: SignUpStyle.signUpBtn,
        child: Center(
          child: Text(
            "Sign Up",
            style: SignUpStyle.signUpText,
          ),
        ),
      ),
    );
  }

  Widget nextBtn(){
    return TextButton(
      onPressed: (){
        // set value of the inputs in form 2
        firstNameCon.text = _firstName;
        lastNameCon.text = _lastName;
        mobileNumberCon.text = _mobileNumber;

        setState(() {
          if(!formKey.currentState!.validate()){
            return;
          }

          formKey.currentState!.save();
          currentPage++;

          print(_email);
          print(_password);
          print(_confirmPassword);
          print(_firstName);
          print(_lastName);
          print(_mobileNumber);
        });
      }, 
      child: Container(
        width: navBtnWidth,
        height: navUpBtnHeight,
        margin: EdgeInsets.only(top: 13, bottom: 11),
        decoration: SignUpStyle.signUpBtn,
        child: Center(
          child: Text(
            "Next",
            style: SignUpStyle.signUpText,
          ),
        )
      )
    );
  }

  Widget backBtn(){
    return TextButton(
      onPressed: (){
        // set value of the inputs in form 2
        emailCon.text = _email;
        passwordCon.text = _password;
        confirmPasswordCon.text = _confirmPassword;
        setState(() {
          currentPage--;
        });
      }, 
      child: Container(
        width: navBtnWidth,
        height: navUpBtnHeight,
        margin: EdgeInsets.only(top: 13, bottom: 11),
        decoration: SignUpStyle.signUpBtn,
        child: Center(
          child: Text(
            "Back",
            style: SignUpStyle.signUpText,
          ),
        ),
      )
    );
  }
}