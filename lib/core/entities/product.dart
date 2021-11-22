import 'package:landgo_seller/core/models/product_add_on_groups_model.dart';
import 'package:landgo_seller/core/models/product_size_model.dart';

class Product {
  int id;
  String name;
  String categoryName;
  String description;
  String image;
  List<ProductSizeModel> sizes;
  List<ProductAddOnGroupModel> addOnGroups;

  Product({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.description,
    required this.image,
    required this.sizes,
    required this.addOnGroups
  });
}