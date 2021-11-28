import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landgo_seller/core/controllers/seller_controller.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/product_model.dart';
import 'package:landgo_seller/core/models/product_size_model.dart';
import 'package:landgo_seller/core/models/size_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';
import 'package:landgo_seller/core/widgets/pop_up.dart';
import 'package:provider/provider.dart';

class ProductFormController extends ChangeNotifier {
  // Private Variables
  bool _isNew = false;
  final ImagePicker _picker = ImagePicker();
  List _productCategories = [];
  List<SizeModel> _sizes = [];
  List _productAddOnGroups = [];
  late SellerController _sellerController;

  // form variables
  String _formName = "";
  String _formDescription = "";
  Map _selectedProductCategory = {"id": 0,   "name": ""};
  List<ProductSizeModel> _selectedProductSizes = [];
  List _selectedProductAddOnGroups = [];

  // Public Variables
  bool get isNew => _isNew;
  UnmodifiableListView get productCategories => UnmodifiableListView(_productCategories);
  Map get selectedProductCategory => _selectedProductCategory;
  UnmodifiableListView<SizeModel> get sizes => UnmodifiableListView<SizeModel>(_sizes);
  UnmodifiableListView<ProductSizeModel> get selectedProductSizes => UnmodifiableListView<ProductSizeModel>(_selectedProductSizes);
  UnmodifiableListView get productAddOnGroups => UnmodifiableListView(_productAddOnGroups);
  UnmodifiableListView get selectedProductAddOnGroups => UnmodifiableListView(_selectedProductAddOnGroups);

  // Functions
  void setProduct(BuildContext context)async{
    // set seller controller
    _sellerController = Provider.of<SellerController>(context, listen: false);
    
    _isNew = _sellerController.chosenProduct.id == 0;

    String _getProductFormDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products/product_form";
    Map _response = await HttpRequestFunction.getData(_getProductFormDataUrl, _sellerController.headers);
    Map _responseBody = _response['body'];
    print("==================");
    print(_responseBody);

    // save categories and set selected category
    _productCategories = _responseBody['product_categories'];
    _selectedProductCategory = _productCategories.first;

    // save sizes and set selected size
    for (var _ps in _responseBody['product_sizes']) {
      _sizes.add(SizeModel.fromJson(_ps));
    }
    if(_isNew){
      _selectedProductSizes.add(ProductSizeModel(size: _sizes.first, price: 0, basePrice: 0));
    }else{
      for (ProductSizeModel _productSize in _sellerController.chosenProduct.sizes) {
        _selectedProductSizes.add(_productSize);
      }
    }

    // save add on groups
    for (var _aog in _responseBody['add_on_groups']) {
      _productAddOnGroups.add({
        'id': _aog['id'],
        'name': _aog['name']
      });
    }
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
    _selectedProductSizes[_index].size = value;
    notifyListeners();
  }

  void addSize(){
    _selectedProductSizes.add(ProductSizeModel(size: _sizes.first, price: 0, basePrice: 0));
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
    _selectedProductSizes[_index].price = value;
  }

  void addAddOnGroup(){
    _selectedProductAddOnGroups.add({
      'add_on_group': _productAddOnGroups.first,
      'require': 0,
      'num_of_select': 0
    });
    notifyListeners();
  }
  
  void removeAddOnGroup(int _index){
    _selectedProductAddOnGroups.removeAt(_index);
    notifyListeners();
  }

  String? validateAddOnGroupRequire(String? value){
    if(value == null || value == ""){
      return "Require is required";
    }

    return null;
  }

  void saveRequire(value, int _index){
    _selectedProductAddOnGroups[_index]['require'] = value;
    notifyListeners();
  }

  String? validateAddOnGroupNumSelect(String? value){
    if(value == null || value == ""){
      return "Num of Select is required";
    }

    return null;
  }

  void saveNumSelect(value, int _index){
    _selectedProductAddOnGroups[_index]['num_of_select'] = value;
    notifyListeners();
  }

  Future<dynamic> saveProduct(BuildContext context)async{
    Map _data = {
      'name': _formName,
      'description': _formDescription,
      'product_category_id': _selectedProductCategory['id'],
      'product_sizes': _selectedProductSizes,
      'product_add_on_groups': _selectedProductAddOnGroups
    };

    String _getProductFormDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/products";
    Map _response = await HttpRequestFunction.sendData(_getProductFormDataUrl, _sellerController.headers, _data);
    Map _responseBody = _response['body'];
    
    if(_response['status'] == 200){ // successful
      ProductModel _newProduct = ProductModel.fromJson(_responseBody['product']);
      _sellerController.addProductToList(_newProduct);
      Navigator.pop(context);
    }else if(_response['status'] == 422){ // doesnt have account
      PopUp.error(context, _responseBody['status']);
    }else if(_response['status'] == 401){ // invalid creds
      PopUp.error(context, _responseBody['errors'][0]);
    }else{  // 500 status code
      PopUp.error(context);
    }
  }
}