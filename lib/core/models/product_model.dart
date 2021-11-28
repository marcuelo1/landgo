import 'package:landgo_seller/core/entities/product.dart';
import 'package:landgo_seller/core/models/product_add_on_groups_model.dart';
import 'package:landgo_seller/core/models/product_size_model.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String categoryName,
    required String description,
    required String image,
    required List<ProductSizeModel> sizes,
    required List<ProductAddOnGroupModel> addOnGroups,
  }) : super(
    id: id,
    name: name,
    categoryName: categoryName,
    description: description,
    image: image,
    sizes: sizes,
    addOnGroups: addOnGroups
  );

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<ProductModel> _data = [];

      for (var p in json) {
        _data.add(_productInfo(p));
      }

      return _data;
    }else{  // if json received is a map
      return _productInfo(json);
    }
  }

  static ProductModel _productInfo(Map<String, dynamic> json){
    return ProductModel(
      id: (json['id'] as num).toInt(), 
      name: json['name'], 
      categoryName: json['product_category_name'],
      description: json['description'],
      image: json['image'],
      sizes: ProductSizeModel.fromJson(json['sizes']),
      addOnGroups: ProductAddOnGroupModel.fromJson(json['add_on_groups'])
    );
  }

  static ProductModel newProduct(){
    return ProductModel(id: 0, name: "", categoryName: "", description: "", image: "", sizes: [], addOnGroups: []);
  }
}