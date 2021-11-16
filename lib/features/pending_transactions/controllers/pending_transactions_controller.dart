import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/core/functions/http_request_function.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/core/network/app_url.dart';

class PendingTransactionsController {
  String getPendingTransactionsDataUrl = "${AppUrl.root}/${AppUrl.version}/seller/transactions/pending";
  List transactions = [];
  Map _headers = {};

  void setHeader(){
    _headers = Headers.getJson();
    print(_headers);
  }

  void getPendingTransactionsData()async{
    // get headers
    setHeader();
    // request data from the server
    Map _response = await HttpRequestFunction.getData(getPendingTransactionsDataUrl, _headers);
    Map _responseBody = _response['body'];

    transactions = TransactionModel.fromJson(_responseBody['pending_transactions']);
  }
}