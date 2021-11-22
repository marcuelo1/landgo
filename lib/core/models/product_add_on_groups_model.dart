import 'package:landgo_seller/core/entities/product_add_on_group.dart';
import 'package:landgo_seller/core/models/add_on_group_model.dart';

class ProductAddOnGroupModel extends ProductAddOnGroup {
  ProductAddOnGroupModel({
    required int id,
    required String name,
    required int require,
    required int numOfSelect,
    required List<AddOnModel> addOns
  }) : super(
    id: id,
    name: name,
    require: require,
    numOfSelect: numOfSelect,
    addOns: addOns
  );

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<ProductAddOnGroupModel> _data = [];

      for (var paog in json) {
        _data.add(_productAddOnGroupInfo(paog));
      }

      return _data;
    }else{  // if json received is a map
      return _productAddOnGroupInfo(json);
    }
  }

  static ProductAddOnGroupModel _productAddOnGroupInfo(Map<String, dynamic> json){
    return ProductAddOnGroupModel(
      id: (json['id'] as num).toInt(), 
      name: json['name'],
      require: (json['require'] as num).toInt(), 
      numOfSelect: (json['num_of_select'] as num).toInt(),
      addOns: AddOnModel.fromJson(json['add_ons']),
    );
  }
}