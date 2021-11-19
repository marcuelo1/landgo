import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/error_page.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ListOfVouchers extends StatefulWidget {
  static const String routeName = "list_of_vouchers";

  @override
  _ListOfVouchersState createState() => _ListOfVouchersState();
}

class _ListOfVouchersState extends State<ListOfVouchers> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/vouchers";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  List vouchers = [];
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

            vouchers = responseBody["vouchers"];
            print(vouchers);
            print("============================================================== vouchers");

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, title: "Vouchers"),
        body: Center(
          child: Column(
            children: [
              for (var _voucher in vouchers) ... [
                SharedWidgets.voucher(_voucher, width, height),
                SizedBox(height: SharedFunction.scaleHeight(10, height),)
              ]
            ],
          ),
        ),
      )
    );
  }
}