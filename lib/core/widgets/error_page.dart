import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';

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
        appBar: SharedWidgets.appBar(context),
        body: Center(
          child: Text("Error"),
        ),
      )
    );
  }
}