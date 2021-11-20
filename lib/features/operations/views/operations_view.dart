import 'package:flutter/material.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/features/operations/controllers/operations_controller.dart';

class OperationsView extends StatefulWidget {
  static const String routeName = "operations_views";

  @override
  _OperationsViewState createState() => _OperationsViewState();
}

class _OperationsViewState extends State<OperationsView> {
  OperationsController con = OperationsController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => con.onPressedProducts(context), 
              child: const Text("Products")
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Add Ons")
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Schedule")
            ),
            SizedBox(height: 10),
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