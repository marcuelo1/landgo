import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/error_page.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ListOfTransactions extends StatefulWidget {
  static const String routeName = "list_of_transactions";

  @override
  _ListOfTransactionsState createState() => _ListOfTransactionsState();
}

class _ListOfTransactionsState extends State<ListOfTransactions> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  List completed = [];
  List canceled = [];
  bool showCompleted = true;
  bool showCanceled = false;
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
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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

            completed = responseBody["completed"];
            print(completed);
            print("============================================================== completed");

            canceled = responseBody["canceled"];
            print(canceled);
            print("============================================================== completed");

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, title: "Transactions"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headerButtons(),
            SizedBox(height: SharedFunction.scaleHeight(20, height),),
            if(showCompleted) ... [
              transactionsContainer(completed)
            ],
            if(showCanceled) ... [
              transactionsContainer(canceled)
            ]
          ],
        ),
      )
    );
  }

  Widget headerButtons(){
    return Row(
      children: [
        headerBtn("Completed"),
        headerBtn("Canceled")
      ],
    );
  }

  Widget headerBtn(String name){
    return ElevatedButton(
      onPressed: (){
        if(name == "Completed"){
          setState(() {
            showCompleted = true;
            showCanceled = false;
          });
        }else{
          setState(() {
            showCompleted = false;
            showCanceled = true;
          });
        }
      }, 
      style: SharedStyle.yellowBtn,
      child: Center(
        child: Text(
          name,
          style: SharedStyle.yellowBtnText,
        ),
      )
    );
  }

  Widget transactionsContainer(List _transactions){
    return Column(
      children: [
        for (var _transaction in _transactions) ... [
          transactionContent(_transaction)
        ]
      ],
    );
  }

  Widget transactionContent(Map _transaction){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          transactionNameAndTotal(_transaction),
          transactionDetails(_transaction)
        ],
      )
    );
  }

  Widget transactionNameAndTotal(Map _transaction){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_transaction['seller_name']),
        Text("₱${_transaction['total'].toStringAsFixed(2)}")
      ],
    );
  }

  Widget transactionDetails(Map _transaction){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(_transaction['products_names']),
            Text(_transaction['date'])
          ],
        ),
      ],
    );
  }
  
}