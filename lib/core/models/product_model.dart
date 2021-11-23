import 'package:ryve_mobile/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String categoryName,
    required String description,
    required String image,
  }) : super(
          id: id,
          name: name,
          categoryName: categoryName,
          description: description,
          image: image,
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
      categoryName: json['product_category_name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
