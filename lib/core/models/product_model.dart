import 'package:ryve_mobile/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required int product_category_id,
    required String description,
    required String image,
    required double price,
    required double base_price,
  }) : super(
          id: id,
          name: name,
          description: description,
          product_category_id: product_category_id,
          image: image,
          price: price,
          base_price: base_price,
        );

  static fromJson(json) {
    if (json is List) {
      // if json received is an array
      List<ProductModel> _data = [];

      for (var p in json) {
        _data.add(_productInfo(p));
      }

      return _data;
    } else {
      // if json received is a map
      return _productInfo(json);
    }
  }

  static ProductModel _productInfo(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      product_category_id: (json['product_category_id'] as num).toInt(),
      description: json['description'],
      price: json['price'],
      base_price: json['base_price'],
      image: json['image'],
    );
  }
}
