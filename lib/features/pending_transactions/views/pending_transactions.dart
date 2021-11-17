import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/features/pending_transactions/controllers/pending_transactions_controller.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:provider/provider.dart';

class PendingTransactions extends StatefulWidget {
  static const String routeName = "pending_transactions";

  @override
  _PendingTransactionsState createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  double _containerHeight = SharedStyle.referenceHeight - AppBar().preferredSize.height - BarWidgets.bottomAppBarHeight;
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PendingTransactionsController con = Provider.of<PendingTransactionsController>(context);
    // get data
    con.getPendingTransactionsData();

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return SafeArea(
          child: Scaffold(
            appBar: BarWidgets.appBar(context, ),
            bottomNavigationBar: BarWidgets.bottomAppBar(context),
            backgroundColor: SharedStyle.white,
            body: Container(
              width: double.infinity,
              height: StyleFunction.scaleHeight(_containerHeight, height),
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