class Transaction {
  int id;
  double total;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    required this.id, 
    required this.total,
    required this.status,
    required this.createdAt, 
    required this.updatedAt
  });

  static Map statuses = {"Pending": 0, "Accepted": 1, "Delivering": 2, "Completed": 3, "Cancelled": 4};
}