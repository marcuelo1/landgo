import 'dart:convert';

import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/entities/seller.dart';

class SellerModel extends Seller {
  SellerModel({
    required int id,
    required String name,
    required String address,
    required String phoneNumber,
    required String image
  }) : super(
    id: id,
    name: name,
    address: address,
    phoneNumber: phoneNumber,
    image: image
  );


  static fromJson(json){
    if(json is List){ // if json received is an array
      List<SellerModel> _data = [];

      for (var tm in json) {
        _data.add(_sellerInfo(tm));
      }

      return _data;
    }else{  // if json received is a map
      return _sellerInfo(json);
    }
  }

  static SellerModel _sellerInfo(Map<String, dynamic> json){
    return SellerModel(
      id: (json['id'] as num).toInt(), 
      name: json['name'], 
      address: json['address'],
      phoneNumber: json['phone_number'], 
      image: json['image'], 
    );
  }

  static get getSeller => jsonDecode(SharedPreferencesData.getKeyData('seller'));
}