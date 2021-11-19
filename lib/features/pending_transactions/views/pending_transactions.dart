import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/models/transaction_model.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/core/widgets/card_widgets.dart';
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
  late PendingTransactionsController con;

  double _containerHeight = SharedStyle.referenceHeight - AppBar().preferredSize.height - BarWidgets.bottomAppBarHeight;
  
  @override
  void initState(){
    super.initState();
    con = Provider.of<PendingTransactionsController>(context, listen: false);
    // get data
    con.getPendingTransactionsData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    print("BUILDING VIEW");
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context, ),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Container(
          width: double.infinity,
          height: StyleFunction.scaleHeight(_containerHeight, height),
          child: ListView(
            children: [
              for (TransactionModel transaction in con.transactions) ... [
                CardWidgets.card(
                  cardWidth: 250, 
                  referenceWidth: width, 
                  child: Column(
                    children: [
                      // transaction id
                      Text(transaction.idString),
                      // transaction seller total
                      Text(transaction.totalString),
                      // buttons
                      Row(
                        children: [
                          if(transaction.is_accepted)...[
                            // complete button
                            ElevatedButton(
                              onPressed: () => con.toDeliver(), 
                              child: const Text("Complete")
                            )
                          ]else...[
                            // accept and decline button
                            ElevatedButton(
                              onPressed: () => con.acceptTransaction(), 
                              child: const Text("Accept")
                            ),
                            ElevatedButton(
                              onPressed: () => con.declinceTransaction(), 
                              child: const Text("Decline")
                            )
                          ],
                          // view details button
                        ],
                      )
                    ],
                  )
                )
              ]
            ],
          ),
        ),
      )
    );
  }
}