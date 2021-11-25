import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/entities/seller.dart';
import 'package:ryve_mobile/core/models/seller_model.dart';
import 'package:ryve_mobile/features/sellers/styles/show_seller_style.dart';
import 'package:ryve_mobile/features/sellers/views/product.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';
import 'package:ryve_mobile/features/sellers/controllers/seller_controller.dart';
import 'package:provider/provider.dart';

class ShowSeller extends StatefulWidget {
  static const String routeName = "show_seller";

  @override
  _ShowSellerState createState() => _ShowSellerState();
}

class _ShowSellerState extends State<ShowSeller> {
  late SellerController con;
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double sellerImageWidth = 375;
  final double sellerImageHeight = 200;
  final double listOfProductsWidth = 375;
  final double categoryHeight = 40;
  final double categoryNameWidth = 70;

  @override
  void initState() {
    super.initState();
    con = Provider.of<SellerController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    SellerModel seller;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;
    seller = ModalRoute.of(context)!.settings.arguments as SellerModel;
    con.getSpecificSeller(seller);

    return SafeArea(
      child: Scaffold(
        appBar:
            SharedWidgets.appBar(context, title: seller.name, showCart: true),
        body: SingleChildScrollView(child: Consumer<SellerController>(
          builder: (_, _sellers, __) {
            return Column(
              children: [
                // seller image
                sellerImage(seller.image),
                // product categories
                productCategories(con.product_categories),
                // list of products
                listOfProducts(con.products),
              ],
            );
          },
        )),
      ),
    );
  }

  Widget sellerImage(String url) {
    return Container(
      width: SharedFunction.scaleWidth(sellerImageWidth, width),
      height: SharedFunction.scaleHeight(sellerImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget productCategories(List _product_categories) {
    return Container(
      height: SharedFunction.scaleHeight(categoryHeight, height),
      color: SharedStyle.black2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < _product_categories.length; i++) ...[
            productCategoryName(_product_categories[i]['name']),
          ]
        ],
      ),
    );
  }

  Widget productCategoryName(String name) {
    return Container(
      width: categoryNameWidth,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Text(
            name,
            style: ShowSellerStyle.productCategoryName,
          ),
        ),
      ),
    );
  }

  Widget listOfProducts(List _products) {
    return Container(
      width: SharedFunction.scaleWidth(listOfProductsWidth, width),
      height: (height -
          SharedFunction.scaleHeight(categoryHeight, height) -
          AppBar().preferredSize.height),
      child: ListView(
        children: [
          for (var i = 0; i < _products.length; i++) ...[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Product.routeName,
                      arguments: {"product": _products[i]});
                },
                child: SharedWidgets.product(_products[i], width, height))
          ]
        ],
      ),
    );
  }
}
