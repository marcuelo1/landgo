import 'package:flutter/material.dart';
import 'package:landgo_seller/core/models/seller_model.dart';

class SellerController extends ChangeNotifier {
  SellerModel seller = SellerModel.getSeller;
}