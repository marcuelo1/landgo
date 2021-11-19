class TransactionProduct {
  int productId;
  int quantity;
  String size;
  List addOns;

  TransactionProduct({
    required this.productId,
    required this.quantity,
    required this.size,
    required this.addOns
  });
}