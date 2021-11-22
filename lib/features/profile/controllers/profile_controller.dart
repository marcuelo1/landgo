import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:landgo_seller/core/controllers/seller_controller.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/seller_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class ProfileController extends SellerController {
  // Private Variables
  String _getProfileDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/profile";
  Map<String, String> _headers = {};

  // Public Variable

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }

  void getProfileData()async{
    print("GETTING PROFILE DATA");
    // get headers
    setHeader();
    // request data from the server
    Map _response = await HttpRequestFunction.getData(_getProfileDataUrl, _headers);
    Map _responseBody = _response['body'];
    print("=============================");
    print(_responseBody);

    super.seller = SellerModel.fromJson(_responseBody['seller']);
    SharedPreferencesData.saveStringData("seller", jsonEncode(_responseBody['seller']));
    notifyListeners();
  }
}