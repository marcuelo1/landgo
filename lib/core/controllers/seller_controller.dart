import 'package:flutter/material.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/seller_model.dart';

class SellerController extends ChangeNotifier {
  SellerModel _seller = SellerModel.getSeller;
  List<ProductModel> _products = [];

  SellerModel get seller => _seller;

  void saveSeller(SellerModel _sellerData){
    _seller = _sellerData;
    notifyListeners();
  }
}