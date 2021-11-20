import 'package:flutter/material.dart';
import 'package:landgo_seller/features/operations/views/list_of_products_view.dart';

class OperationsController {
  void onPressedProducts(BuildContext context){
    Navigator.pushNamed(context, ListOfProductsView.routeName);
  }
}