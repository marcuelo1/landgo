import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/seller_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class ListOfProductsController extends ChangeNotifier {
  // Private Variables
  String _getProductsDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products";
  List<ProductModel> _products = [];
  Map<String, String> _headers = {};
  SellerModel _seller = SellerModel.getSeller;
  Map isShow = {};

  // Public Variable
  UnmodifiableListView<ProductModel> get products => UnmodifiableListView(_products);

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }

  void getProductsData()async{
    // set headers
    setHeader();

    String _rawUrl = _getProductsDataUrl + "?seller_id=${_seller.id.toString()}";
    Map _response = await HttpRequestFunction.getData(_rawUrl, _headers);
    Map _responseBody = _response['body'];
    print("==================================");
    print(_responseBody);

    if(_response['status'] == 200){
      _products = ProductModel.fromJson(_responseBody['products']);
      notifyListeners();
    }
  }

  void viewDetails(int _productId){
    if(isShow[_productId] == true){
      isShow[_productId] = false;
    }else{
      isShow[_productId] = true;
    }
    notifyListeners();
  }
}