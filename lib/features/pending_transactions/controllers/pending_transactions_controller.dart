import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class PendingTransactionsController extends ChangeNotifier {
  // Private Variables
  String _getPendingTransactionsDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/transactions/pending";
  String _acceptTransactionUrl = "";
  List<TransactionModel> _transactions = [];
  Map<String, String> _headers = {};

  // Public Variable
  UnmodifiableListView<TransactionModel> get transactions => UnmodifiableListView(_transactions);

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }

  void getPendingTransactionsData()async{
    print("GETTING PENDING TRANSACTIONS DATA");
    // get headers
    setHeader();
    // request data from the server
    Map _response = await HttpRequestFunction.getData(_getPendingTransactionsDataUrl, _headers);
    Map _responseBody = _response['body'];
    print("=============================");
    print(_responseBody);

    _transactions = TransactionModel.fromJson(_responseBody['pending_transactions']);
    notifyListeners();
  }

  void toDeliver(){}

  void acceptTransaction()async{
    Map _data = {};
    Map _response = await HttpRequestFunction.sendData(_acceptTransactionUrl, _headers, _data);

  }
  
  void declinceTransaction(){}
}