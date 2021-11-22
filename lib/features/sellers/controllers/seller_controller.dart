import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/models/seller_model.dart';
import 'package:ryve_mobile/features/home/home.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_function.dart';

class SellerController extends ChangeNotifier {
  String _getSellersUrl =
      "${SharedUrl.root}/${SharedUrl.version}/buyer/sellers";
  Map<String, String> _headers = {};

  List category_deals = []; // category deals
  List<SellerModel> top_sellers = []; // top_sellers
  List<SellerModel> recent_sellers = []; // recent_sellers
  List<SellerModel> all_sellers = []; // all sellers

  UnmodifiableListView<SellerModel> get topSellers =>
      UnmodifiableListView(top_sellers);
  UnmodifiableListView<SellerModel> get recentSellers =>
      UnmodifiableListView(recent_sellers);
  UnmodifiableListView<SellerModel> get allSellers =>
      UnmodifiableListView(all_sellers);

  void setHeader() {
    _headers = Headers.getHeaders();
    print(_headers);
  }

  void getSellersData(category) async {
    print("GETTING SELLERS DATA");
    // get headers
    setHeader();
    //get url
    String url = _getSellersUrl + "?id=${category['id']}";
    // request data from the server
    Map _response = await SharedFunction.getData(url, _headers);
    Map _responseBody = _response['body'];

    top_sellers = SellerModel.fromJson(_responseBody['top_sellers']);
    recent_sellers = SellerModel.fromJson(_responseBody['recent_sellers']);
    all_sellers = SellerModel.fromJson(_responseBody['all_sellers']);

    category_deals = _responseBody['category_deals'];
    print("=============================");
    print(_responseBody);

    notifyListeners(); //install provider
  }
}
