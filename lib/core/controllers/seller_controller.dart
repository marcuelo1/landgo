import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/seller_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class SellerController extends ChangeNotifier {
  // Private Variables
  String _getProductsDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products";
  SellerModel _seller = SellerModel.getSeller;
  List<ProductModel> _products = [];
  Map<String, String> _headers = SharedPreferencesData.getHeader();
  late ProductModel _chosenProduct;

  // Public Variables
  SellerModel get seller => _seller;
  UnmodifiableListView<ProductModel> get products => UnmodifiableListView(_products);
  Map<String, String> get headers => _headers;
  ProductModel get chosenProduct => _chosenProduct;

  // Functions
  void saveSeller(SellerModel _sellerData){
    _seller = _sellerData;
    notifyListeners();
  }

  void setProducts()async{
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

  void setChosenProduct(ProductModel _productData){
    _chosenProduct = _productData;
    notifyListeners();
  }

  void addProductToList(ProductModel _newProduct){
    _chosenProduct = _newProduct;
    _products.add(_newProduct);
    notifyListeners();
  }
  
  void updateProductInList(ProductModel _updatedProduct){
    _chosenProduct = _updatedProduct;
    int _productIndex = _products.indexWhere((_product) => _product.id == _updatedProduct.id);
    _products[_productIndex] = _updatedProduct;
    notifyListeners();
  }
}