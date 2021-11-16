import 'package:flutter/material.dart';
import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/features/pending_transactions/controllers/pending_transactions_controller.dart';
import 'package:landgo_seller/shared/shared_function.dart';
import 'package:landgo_seller/shared/shared_style.dart';
import 'package:landgo_seller/shared/shared_widgets.dart';

class PendingTransactions extends StatefulWidget {
  static const String routeName = "pending_transactions";

  @override
  _PendingTransactionsState createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {
  PendingTransactionsController con = PendingTransactionsController();

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  double _containerHeight = SharedStyle.referenceHeight - AppBar().preferredSize.height - SharedWidgets.bottomAppBarHeight;

  // headers
  Map _headers = {};
  @override
  void initState(){
    super.initState();
    // get headers
    _headers = Headers.getJson();
    print(_headers);
    // get data
    con.getPendingTransactionsData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return SafeArea(
          child: Scaffold(
            appBar: SharedWidgets.appBar(context, title: "Seller"),
            bottomNavigationBar: SharedWidgets.bottomAppBar(context),
            backgroundColor: SharedStyle.white,
            body: Container(
              width: double.infinity,
              height: SharedFunction.scaleHeight(_containerHeight, height),
              child: ListView(
                children: [
                  for (TransactionModel transaction in con.transactions) ... [
                    
                  ]
                ],
              ),
            ),
          )
        );
      }
    );
  }
}