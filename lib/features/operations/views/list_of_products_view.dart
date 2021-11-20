import 'package:flutter/material.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';

class ListOfProductsView extends StatefulWidget {
  static const String routeName = "list_of_products_view";

  @override
  _ListOfProductsViewState createState() => _ListOfProductsViewState();
}

class _ListOfProductsViewState extends State<ListOfProductsView> {
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
            Text("Product"),
            // Add Product Button
            // List of Products
          ],
        ),
      ),
    );
  }
}