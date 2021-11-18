import 'package:flutter/material.dart';
import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/network/app_url.dart';
import 'package:landgo_seller/features/pending_transactions/views/pending_transactions.dart';
import 'package:landgo_seller/core/widgets/pop_up.dart';

class SignInController {
  String signInUrl = "${AppUrl.root}/${AppUrl.version}/sellers/sign_in";
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
    Map _response = await HttpRequestFunction.sendData(this.signInUrl, {}, _data);
    Map _responseBody = _response['body'];

    if(_response['status'] == 200){ // successful
      // save headers
      Headers.save(_response['headers']);
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