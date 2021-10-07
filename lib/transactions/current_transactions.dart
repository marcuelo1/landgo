import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/error_page.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';
import 'package:ryve_mobile/transactions/current_transaction_show.dart';

class CurrentTransactions extends StatefulWidget {
  static const String routeName = "current_transaction";

  @override
  _CurrentTransactionsState createState() => _CurrentTransactionsState();
}

class _CurrentTransactionsState extends State<CurrentTransactions> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts/current_transactions";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  List currentTransactions = [];
  bool refresh = true;

  // headers
  Map<String, String> _headers = {};
  @override
  void initState() {
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return !refresh ? content(context) : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ErrorPage();
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if (snapshot.hasError) {
              return  ErrorPage();
            }
            refresh = false;

            // get response
            var response = snapshot.data;
            var responseBody = response['body'];
            print(responseBody);
            print("============================================================== response body");

            if(responseBody['checkout_sellers'].length > 0){
              currentTransactions = json.decode(responseBody['checkout_sellers']);
            }

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        body: currentTransactions.isEmpty ? emptyContent() : currentTransactionsContainer(),
      )
    );
  }

  Widget emptyContent() {
    return Center(
      child: Text("No Current Transactions"),
    );
  }

  Widget currentTransactionsContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var _ct in currentTransactions) ... [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, CurrentTransactionShow.routeName, arguments: {"checkout_seller": _ct});
            },
            child: currentTransactionContent(_ct),
          ),
          SizedBox(height: SharedFunction.scaleHeight(20, height),)
        ]
      ],
    );
  }

  Widget currentTransactionContent(Map _ct){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_ct['seller_name']),
        Text(_ct['status']),
      ],
    );
  }
}