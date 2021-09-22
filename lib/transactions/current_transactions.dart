import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class CurrentTransactions extends StatefulWidget {
  static const String routeName = "review_payment_location";

  @override
  _CurrentTransactionsState createState() => _CurrentTransactionsState();
}

class _CurrentTransactionsState extends State<CurrentTransactions> {
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/checkouts";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

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

    return content(context);
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
      )
    );
  }
}