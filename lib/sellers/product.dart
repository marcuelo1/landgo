import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/sellers/product_style.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Product extends StatefulWidget {
  const Product({ Key? key }) : super(key: key);
  static const String routeName = "product";

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/product_details";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double productImageWidth = 325;
  final double productImageHeight = 200;

  Map seller = {};
  Map product = {};
  List sizes = [];
  List add_on_groups = [];
  String displayPrice = "";
  int selectedSize = 0;

  // response
  Map response = {};
  Map responseBody = {};
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
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    seller = args['seller'];
    product = args['product'];
    print(seller);
    print(product);
    _dataUrl = _dataUrl + "?id=${product['id']}";
    
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
            responseBody = response['body'];
            print(responseBody);
            print("==============================================================");

            // get sizes
            if(responseBody['sizes'].length > 0){
              sizes = json.decode(responseBody['sizes']);
              // check if product has only one size, so we can display at the bottom of product name
              if(sizes.length == 1){
                displayPrice = sizes[0]['price'].toStringAsFixed(2);
                selectedSize = sizes[0]['id'];
              }
            }

            // get add on groups
            if(responseBody['add_on_groups'].length > 0){
              add_on_groups = json.decode(responseBody['add_on_groups']);
            }
            print(add_on_groups);
            print("==============================================================");

            return PixelPerfect(
              child: SafeArea(
                child: Scaffold(
                  appBar: SharedWidgets.appBar(seller['name']),
                  body: Padding(
                    padding: EdgeInsets.fromLTRB(
                      SharedFunction.scaleWidth(24, width), 
                      SharedFunction.scaleHeight(20, height), 
                      SharedFunction.scaleWidth(24, width), 
                      SharedFunction.scaleHeight(0, height)
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // product image
                            productImage(product['image']),
                            // space
                            SizedBox(height: SharedFunction.scaleHeight(18, height),),
                            // product name
                            productName(product['name']),
                            // space
                            SizedBox(height: SharedFunction.scaleHeight(7, height),),
                            // product price
                            if(sizes.length == 1) ... [
                              productPrice(displayPrice),
                              // space
                              SizedBox(height: SharedFunction.scaleHeight(33, height),),
                            ],
                            // product size
                            if(sizes.length > 1) ... [
                              productSizes(sizes)
                            ],
                            // product add ons
                            if(add_on_groups.length > 0) ... [
                              productAddOns(add_on_groups)
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              )
            );
        }
      }
    );
  }

  Widget productImage(String url){
    return ClipRRect(
      borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
      child: Container(
        width: SharedFunction.scaleWidth(productImageWidth, width),
        height: SharedFunction.scaleHeight(productImageHeight, height),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:SharedStyle.borderRadius(20, 20, 20, 20),
            side: BorderSide(width: 1, color: SharedStyle.tertiaryFill)
          ),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget productName(String name){
    return Text(
      name,
      textAlign: TextAlign.center,
      style: ProductStyle.productName,
    );
  }

  Widget productPrice(String price){
    return Text(
      "₱$price",
      textAlign: TextAlign.center,
      style: ProductStyle.productPrice
    );
  }

  Widget productSizes(List _sizes){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // name
        title("Sizes"),
        // space
        SizedBox(height: SharedFunction.scaleHeight(10, height),),
        // sizes
        for (var size in _sizes) ... [
          productSizeDetail(size),
          // space
          SizedBox(height: SharedFunction.scaleHeight(10, height),)
        ]
      ],
    );
  }

  Widget productSizeDetail(Map size){
    String _name = size['size'];
    String _price = size['price'].toStringAsFixed(2);
    bool selected = selectedSize == size['id'] ? true : false ;
    return ElevatedButton(
      onPressed: (){
        setState(() {
          selectedSize = size['id'];
        });
      }, 
      style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // name
          subTitle(_name, selected),
          // price
          subTitle("₱$_price", selected),
        ],
      )
    );
  }

  Widget productAddOns(List addOnGroups){
    return Column(
      children: [
        for (var aog in addOnGroups) ... [
          addOnGroup(aog)
        ]
      ],
    );
  }

  Widget addOnGroup(Map aog){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title(aog['name'], aog['require'].toString()),
        // space
        SizedBox(height: SharedFunction.scaleHeight(10, height),),
        // add ons
        for (var add_on in aog['add_ons']) ... [
          // add on
          addOn(add_on),
          // space
          SizedBox(height: SharedFunction.scaleHeight(10, height),)
        ]
      ],
    );
  }

  Widget addOn(Map ao){
    String _name = ao['name'];
    String _price = ao['price'].toStringAsFixed(2);
    bool selected = false ;

    return ElevatedButton(
      onPressed: (){}, 
      style: selected ? ProductStyle.selectedBtn : ProductStyle.unselectedBtn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // name
          subTitle(_name, selected),
          // price
          subTitle("₱$_price", selected),
        ],
      )
    );
  }

  Widget title(String name, [String require = "0"]){
    String requireName = "";
    if(name == "Sizes"){
      requireName = "1 Required";
    }else if(require == "0"){
      requireName = "Optional";
    }else{
      requireName = "$require Required";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          name,
          style: ProductStyle.title,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: ProductStyle.requireContainer,
          child: Text(
            requireName,
            style: ProductStyle.require,
          ),
        ),
      ],
    );
  }

  Widget subTitle(String name, bool selected){
    return Text(
      name,
      style: selected ? ProductStyle.selectedSubTitle : ProductStyle.unselectedSubTitle,
    );
  }
}