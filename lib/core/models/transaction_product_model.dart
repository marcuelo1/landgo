import 'package:landgo_seller/core/entities/transaction_product.dart';

class TransactionProductModel extends TransactionProduct {
  TransactionProductModel({
    required int productId,
    required int quantity,
    required String size,
    required String name,
    required List<String> addOns
  }) : super(
    productId: productId,
    quantity: quantity,
    size: size,
    addOns: addOns,
    name: name
  );
  
  static fromJson(json){
    if(json is List){ // if json received is an array
      List<TransactionProductModel> _data = [];

      for (var tm in json) {
        _data.add(_transactionProductInfo(tm));
      }

      return _data;
    }else{  // if json received is a map
      return _transactionProductInfo(json);
    }
  }

  static TransactionProductModel _transactionProductInfo(Map<String, dynamic> json){
    return TransactionProductModel(
      productId: (json['product_id'] as num).toInt(), 
      quantity: (json['quantity'] as num).toInt(), 
      size: json['size'],
      addOns: List<String>.from(json['add_ons']),
      name: json['name']
    );
  }

  String get addOnsString => this.addOns.join(', ');
}