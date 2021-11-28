import 'package:landgo_seller/core/entities/size.dart';

class SizeModel extends Size {
  SizeModel({
    required int id,
    required String name
  }) : super(
    id: id,
    name: name
  );

  static fromJson(json){
    if(json is List){ // if json received is an array
      List<SizeModel> _data = [];

      for (var size in json) {
        _data.add(_sizeInfo(size));
      }

      return _data;
    }else{  // if json received is a map
      return _sizeInfo(json);
    }
  }

  static SizeModel _sizeInfo(Map<String, dynamic> json){
    return SizeModel(
      id: (json['id'] as num).toInt(), 
      name: json['name']
    );
  }
}