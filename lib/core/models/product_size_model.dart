import 'package:landgo_seller/core/entities/product_size.dart';

class ProductSizeModel extends ProductSize {
  ProductSizeModel({
    required String name,
    required double price,
    required double basePrice,
  }) : super(
    name: name,
    price: price,
    basePrice: basePrice
  );

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<ProductSizeModel> _data = [];

      for (var ps in json) {
        _data.add(_productSizeInfo(ps));
      }

      return _data;
    }else{  // if json received is a map
      return _productSizeInfo(json);
    }
  }

  static ProductSizeModel _productSizeInfo(Map<String, dynamic> json){
    return ProductSizeModel(
      name: json['name'], 
      price: (json['price'] as num).toDouble(), 
      basePrice: (json['base_price'] as num).toDouble(), 
    );
  }
}