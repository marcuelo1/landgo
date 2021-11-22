import 'package:landgo_seller/core/entities/add_on_group.dart';

class AddOnGroupModel {
  
}

class AddOnModel extends AddOn {
  AddOnModel({
    required int id,
    required String name,
    required double price
  }) : super(
    id: id,
    name: name,
    price: price
  );

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<AddOnModel> _data = [];

      for (var ao in json) {
        _data.add(_addOnInfo(ao));
      }

      return _data;
    }else{  // if json received is a map
      return _addOnInfo(json);
    }
  }

  static AddOnModel _addOnInfo(Map<String, dynamic> json){
    return AddOnModel(
      id: (json['id'] as num).toInt(), 
      name: json['name'], 
      price: (json['price'] as num).toDouble(),
    );
  }
}