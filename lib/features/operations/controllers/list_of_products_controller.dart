import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:landgo_seller/core/controllers/seller_controller.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/seller_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';
import 'package:landgo_seller/features/operations/views/product_form_view.dart';
import 'package:provider/provider.dart';

class ListOfProductsController extends ChangeNotifier {
  // Private Variables
  late SellerController _sellerController;

  // Public Variable
  Map isShow = {};

  // Functions
  void getProductsData(BuildContext context)async{
    // set seller controller
    _sellerController = Provider.of<SellerController>(context, listen: false);

    _sellerController.setProducts();
  }

  void viewDetails(int _productId){
    if(isShow[_productId] == true){
      isShow[_productId] = false;
    }else{
      isShow[_productId] = true;
    }
    notifyListeners();
  }

  void addProductBtn(BuildContext context){
    _sellerController.setChosenProduct(ProductModel.newProduct());
    Navigator.pushNamed(context, ProductFormView.routeName);
  }

  void editProductBtn(BuildContext context, ProductModel _product){
    _sellerController.setChosenProduct(_product);
    Navigator.pushNamed(context, ProductFormView.routeName);
  }
}