import 'package:flutter/material.dart';
import 'package:landgo_seller/pending_transactions/pending_transactions.dart';
import 'package:landgo_seller/shared/headers.dart';
import 'package:landgo_seller/shared/pop_up.dart';
import 'package:landgo_seller/shared/shared_function.dart';
import 'package:landgo_seller/shared/shared_url.dart';

class SignInController {
  String signInUrl = "${SharedUrl.root}/${SharedUrl.version}/buyers/sign_in";
  String _email = "";
  String _password = "";

  String? validateEmail(value){
    // check if input field is empty
    if(value!.isEmpty){
      return "Email is required";
    }

    // check if input is valid email
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
      return "Please enter a valid email";
    }
  }

  String? validatePassword(value){
    if(value!.isEmpty){
      return "Password is required";
    }
  }

  void saveEmail(value){
    _email = value;
  }

  void savePassword(value){
    _password = value;
  }

  Future sendData(BuildContext context)async{
    Map _data = {"email": _email, "password": _password};
    Map _response = await SharedFunction.sendData(this.signInUrl, {}, _data);
    Map _responseBody = _response['body'];

    if(_response['status'] == 200){ // successful
      // save headers
      await Headers.setHeaders(_response['headers']);
      // go to home
      Navigator.pushNamed(context, PendingTransactions.routeName);
    }else if(_response['status'] == 422){ // doesnt have account
      PopUp.error(context, _responseBody['status']);
    }else if(_response['status'] == 401){ // invalid creds
      PopUp.error(context, _responseBody['errors'][0]);
    }else{  // 500 status code
      PopUp.error(context);
    }
  }
}