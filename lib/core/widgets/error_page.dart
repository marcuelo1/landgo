import 'package:flutter/material.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({ Key? key }) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        body: Center(
          child: Text("Error"),
        ),
      )
    );
  }
}