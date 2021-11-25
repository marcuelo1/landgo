class Product {
  int id;
  String name;
  int product_category_id;
  String description;
  String image;
  double price;
  double base_price;

  Product({
    required this.id,
    required this.name,
    required this.product_category_id,
    required this.description,
    required this.image,
    required this.price,
    required this.base_price,
  });
}
