import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class ProductFormController extends ChangeNotifier {
  // Private Variables
  String _getProductFormDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products/product_form";
  late ProductModel _chosenProduct;
  bool _isNew = false;
  List _productCategories = [];
  Map<String, String> _headers = {};
  final ImagePicker _picker = ImagePicker();
  List _productSizes = [];

  // form variables
  String _formName = "";
  String _formDescription = "";
  Map _selectedProductCategory = {"id": 0,   "name": ""};
  List _selectedProductSizes = [];

  // Public Variables
  bool get isNew => _isNew;
  ProductModel get product => _chosenProduct;
  bool refresh = true;
  UnmodifiableListView get productCategories => UnmodifiableListView(_productCategories);
  Map get selectedProductCategory => _selectedProductCategory;
  UnmodifiableListView get productSizes => UnmodifiableListView(_productSizes);
  UnmodifiableListView get selectedProductSizes => UnmodifiableListView(_selectedProductSizes);

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }
  
  void setProduct(ProductModel _product)async{
    // set headers
    setHeader();

    _chosenProduct = _product;
    Map _response = await HttpRequestFunction.getData(_getProductFormDataUrl, _headers);
    Map _responseBody = _response['body'];
    print("==================");
    print(_responseBody);

    // save categories and set selected category
    _productCategories = _responseBody['product_categories'];
    _selectedProductCategory = _productCategories.first;

    // save sizes and set selected size
    for (var _ps in _responseBody['product_sizes']) {
      _productSizes.add({
        'id': _ps['id'],
        'name': _ps['name']
      });
    }
    _selectedProductSizes.add({
      'size': _productSizes.first,
      'price': 0
    });

    refresh = false;
    notifyListeners();
  }

  String? validateFormName(value){
    if(value == null || value == ""){
      return "Name is required";
    }
    return null;
  }

  void saveFormName(value){
    _formName = value;
    notifyListeners();
  }

  String? validateFromDesription(value){
    if(value == null || value == ""){
      return "Description is required";
    }

    return null;
  }

  void saveFormDescription(value){
    _formDescription = value;
    notifyListeners();
  }

  void onChangeProductCategory(Map value){
    _selectedProductCategory = value;
    notifyListeners();
  }

  void onPickImage()async{
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print(image);
  }

  void sizeOnChange(value, int _index){
    _selectedProductSizes[_index]['size'] = value;
    notifyListeners();
  }

  void addSize(){
    _selectedProductSizes.add({
      'size': _productSizes.first,
      'price': 0
    });
    notifyListeners();
  }

  void removeSize(int _index){
    _selectedProductSizes.removeAt(_index);
    notifyListeners();
  }

  String? validatePrice(String? value){
    if(value == null || value == ""){
      return "Price is required";
    }

    return null;
  }

  void saveSizePrice(value, int _index){
    _selectedProductSizes[_index]['price'] = value;
  }
}