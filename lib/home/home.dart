import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/shared_widgets.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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