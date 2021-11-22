class TransactionProduct {
  int productId;
  int quantity;
  String size;
  List<String> addOns;
  String name;

  TransactionProduct({
    required this.productId,
    required this.quantity,
    required this.size,
    required this.addOns,
    required this.name
  });
}