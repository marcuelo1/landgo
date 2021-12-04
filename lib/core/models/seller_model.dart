import 'package:ryve_mobile/core/entities/seller.dart';

class SellerModel extends Seller {
  SellerModel({
    required int id,
    required String name,
    required String address,
    required String phoneNumber,
    required String image,
    required double rating,
  }) : super(
            id: id,
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            rating: rating,
            image: image);

  static fromJson(json) {
    if (json is List) {
      // if json received is an array
      List<SellerModel> _data = [];

      for (var tm in json) {
        _data.add(_sellerInfo(tm));
      }

      return _data;
    } else {
      // if json received is a map
      return _sellerInfo(json);
    }
  }

  static SellerModel _sellerInfo(Map<String, dynamic> json) {
    return SellerModel(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      rating: json['rating'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
    );
  }
}
