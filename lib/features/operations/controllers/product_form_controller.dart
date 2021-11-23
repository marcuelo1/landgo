import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class ProductFormController extends ChangeNotifier {
  // Private Variables
  String _getProductFormDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products/product_form";
  late ProductModel _chosenProduct;
  bool _isNew = false;
  List _productCategories = [];
  Map<String, String> _headers = {};
  // form
  String _formName = "";
  String _formDescription = "";
  Map _selectedProductCategory = {"id": 0,   "name": ""};

  // Public Variables
  bool get isNew => _isNew;
  ProductModel get product => _chosenProduct;
  bool refresh = true;
  UnmodifiableListView get productCategories => UnmodifiableListView(_productCategories);
  Map get selectedProductCategory => _selectedProductCategory;

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }
  
  void setProduct(ProductModel _product)async{
    // set headers
    setHeader();

    _chosenProduct = _product;
    Map _response = await HttpRequestFunction.getData(_getProductFormDataUrl, _headers);
    Map _responseBody = _response['body'];
    print("==================");
    print(_responseBody);

    _productCategories = _responseBody['product_categories'];
    _selectedProductCategory = _productCategories.first;
    refresh = false;
    notifyListeners();
  }

  String? validateFormName(value){
    if(value == null || value == ""){
      return "Name is required";
    }
    return null;
  }

  void saveFormName(value){
    _formName = value;
    notifyListeners();
  }

  String? validateFromDesription(value){
    if(value == null || value == ""){
      return "Description is required";
    }

    return null;
  }

  void saveFormDescription(value){
    _formDescription = value;
    notifyListeners();
  }

  void onChangeProductCategory(Map value){
    _selectedProductCategory = value;
    notifyListeners();
  }
}