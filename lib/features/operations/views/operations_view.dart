import 'package:flutter/material.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';

class OperationsView extends StatefulWidget {
  static const String routeName = "operations_views";

  @override
  _OperationsViewState createState() => _OperationsViewState();
}

class _OperationsViewState extends State<OperationsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Products")
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Add Ons")
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Schedule")
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Call For Support")
            ),
          ],
        ),
      ),
    );
  }
}