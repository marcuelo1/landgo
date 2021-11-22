import 'package:landgo_seller/core/entities/transaction.dart';
import 'package:landgo_seller/core/entities/transaction_product.dart';
import 'package:landgo_seller/core/models/transaction_product_model.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required int id,
    required double total,
    required String status,
    required DateTime createdAt, 
    required DateTime updatedAt,
    required List<TransactionProductModel> products
  }) : super(
    id: id, 
    total: total,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
    products: products
  );

  String get idString => id.toString();
  String get totalString => "₱${total.toStringAsFixed(2)}";
  bool get is_accepted => status == "Accepted";
  bool get delivering => status == "Delivering";

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<TransactionModel> _data = [];

      for (var tm in json) {
        _data.add(_transactionInfo(tm));
      }

      return _data;
    }else{  // if json received is a map
      return _transactionInfo(json);
    }
  }

  static TransactionModel _transactionInfo(Map<String, dynamic> json){
    return TransactionModel(
      id: (json['id'] as num).toInt(), 
      total: (json['total'] as num).toDouble(), 
      status: json['status'],
      createdAt: (json['createdAt'] as DateTime), 
      updatedAt: (json['updatedAt'] as DateTime), 
      products: TransactionProductModel.fromJson(json['products'])
    );
  }

}