import 'package:landgo_seller/core/models/transaction_product_model.dart';

class Transaction {
  int id;
  double total;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<TransactionProductModel> products;

  Transaction({
    required this.id, 
    required this.total,
    required this.status,
    required this.createdAt, 
    required this.updatedAt,
    required this.products
  });

  static Map statuses = {"Pending": 0, "Accepted": 1, "Delivering": 2, "Completed": 3, "Cancelled": 4};
}