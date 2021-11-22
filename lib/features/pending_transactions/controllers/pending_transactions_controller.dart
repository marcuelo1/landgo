import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/core/models/transaction_product_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class PendingTransactionsController extends ChangeNotifier {
  // Private Variables
  String _getPendingTransactionsDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/transactions/pending";
  String _acceptTransactionUrl = "${AppUrl.root}/${AppUrl.version}/seller/transactions/accept";
  String _toDeliverTransactionUrl = "${AppUrl.root}/${AppUrl.version}/seller/transactions/to_deliver";
  List<TransactionModel> _transactions = [];
  Map<String, String> _headers = {};
  Map isShow = {};

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

  void toDeliver(int _transactionId)async{
    Map _data = {
      "transaction_id": _transactionId
    };
    Map _response = await HttpRequestFunction.sendData(_toDeliverTransactionUrl, _headers, _data, "put");
    Map _responseBody = _response['body'];
    print("=============================");
    print(_responseBody);

    int _transacIndex = _transactions.indexWhere((t) => t.id == _transactionId);
    _transactions[_transacIndex] = TransactionModel.fromJson(_responseBody['transaction']);
    print("updated status");
    notifyListeners();
  }

  void acceptTransaction(int _transactionId)async{
    Map _data = {
      "transaction_id": _transactionId
    };
    Map _response = await HttpRequestFunction.sendData(_acceptTransactionUrl, _headers, _data, "put");
    Map _responseBody = _response['body'];
    print("=============================");
    print(_responseBody);

    int _transacIndex = _transactions.indexWhere((t) => t.id == _transactionId);
    _transactions[_transacIndex] = TransactionModel.fromJson(_responseBody['transaction']);
    print("updated status");
    notifyListeners();
  }
  
  void declinceTransaction(){}

  void transactionDetails(int _transactionId)async{
    if(isShow[_transactionId] == true){
      isShow[_transactionId] = false;
    }else{
      isShow[_transactionId] = true;
    }
    notifyListeners();
  }
}