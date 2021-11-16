import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/shared/shared_function.dart';
import 'package:landgo_seller/shared/shared_url.dart';

class PendingTransactionsController {
  String getPendingTransactionsDataUrl = "${SharedUrl.root}/${SharedUrl.version}/seller/transactions/pending";
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
    Map _response = await SharedFunction.getData(getPendingTransactionsDataUrl, _headers);
    Map _responseBody = _response['body'];

    transactions = TransactionModel.fromJson(_responseBody['pending_transactions']);
  }
}