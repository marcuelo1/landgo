import 'package:landgo_seller/features/pending_transactions/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required int id,
    required String status
  }) : super(id: id, status: status);

  factory TransactionModel.fromJson(Map<String, dynamic> json){
    return TransactionModel(
      id: json['id'], 
      status: json['status']
    );
  }
}