import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/sellers/list_of_products_style.dart';
import 'package:ryve_mobile/sellers/product.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ListOfProducts extends StatefulWidget {
  static const String routeName = "list_of_products";

  @override
  _ListOfProductsState createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/list_of_products";
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

  Map seller = {};
  List product_categories = [];
  List products = [];
  // response
  Map response = {};
  // headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;
    seller = ModalRoute.of(context)!.settings.arguments as Map;
    print(seller);
    _dataUrl = _dataUrl + "?id=${seller['id']}";

    return FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("check internet");
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }

            // get response
            response = snapshot.data;
            Map responseBody = response['body'];
            print(responseBody);

            // get product categories
            if(responseBody['product_categories'].length > 0){
              product_categories = json.decode(responseBody['product_categories']);
            }
            // get products
            if(responseBody['products'].length > 0){
              products = json.decode(responseBody['products']);
            }

            return Scaffold(
              appBar: SharedWidgets.appBar(context, ""),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // seller image
                    sellerImage(seller['image']),
                    // product categories
                    productCategories(product_categories),
                    // list of products
                    listOfProducts(products)
                  ],
                ),
              ),
            );
        }
      }
    );
  }

  Widget sellerImage(String url){
    return Container(
      width: SharedFunction.scaleWidth(sellerImageWidth, width),
      height: SharedFunction.scaleHeight(sellerImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget productCategories(List _product_categories){
    return Container(
      height: SharedFunction.scaleHeight(categoryHeight, height),
      color: SharedStyle.black2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < _product_categories.length; i++) ... [
            productCategoryName(_product_categories[i]['name']),
          ]
        ],
      ),
    );
  }

  Widget productCategoryName(String name){
    return Container(
      width: categoryNameWidth,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Text(
            name,
            style: ListOfProductsStyle.productCategoryName,
          ),
        ),
      ),
    );
  }

  Widget listOfProducts(List _products){
    return  Container(
      width: SharedFunction.scaleWidth(listOfProductsWidth, width),
      height: (height - SharedFunction.scaleHeight(categoryHeight, height) - AppBar().preferredSize.height),
      child: ListView(
        children: [
          for (var i = 0; i < products.length; i++) ... [
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, Product.routeName, arguments: {"seller": seller, "product": products[i]});
              },
              child: SharedWidgets.product(products[i]['image'], products[i]['name'], products[i]['price'].toStringAsFixed(2), width, height)
            )
          ]
        ],
      ),
    );
  }
}