import 'package:landgo_seller/core/models/add_on_group_model.dart';

class ProductAddOnGroup {
  int id; // add on group id
  String name;
  int require;
  int numOfSelect;
  List<AddOnModel> addOns;

  ProductAddOnGroup({
    required this.id,
    required this.name,
    required this.require,
    required this.numOfSelect,
    required this.addOns
  });
}