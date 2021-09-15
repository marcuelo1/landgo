import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ryve_mobile/sellers/list_of_products.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Sellers extends StatefulWidget {
  static const String routeName = "sellers";
  
  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/list_of_stores";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double categoryImage = 50;

  // category deals
  List category_deals = [];
  // top_sellers
  List top_sellers = [];
  // recent_sellers
  List recent_sellers = [];
  // all sellers
  List all_sellers = [];
  
  Map location = {};

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

    final Map category = ModalRoute.of(context)!.settings.arguments as Map;
    print(category);
    
    return FutureBuilder(
      future: SharedFunction.getDataWithLoc(_dataUrl, _headers, location, {"id": category['id']}),
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
            if(responseBody['category_deals'].length > 0){
              category_deals = json.decode(responseBody['category_deals']);
            }

            if(responseBody['top_sellers'].length > 0){
              top_sellers = json.decode(responseBody['top_sellers']);
            }

            if(responseBody['recent_sellers'].length > 0){
              recent_sellers = json.decode(responseBody['recent_sellers']);
            }

            if(responseBody['all_sellers'].length > 0){
              all_sellers = json.decode(responseBody['all_sellers']);
            }

            return SafeArea(
              child: Scaffold(
                body: Scaffold(
                  appBar: SharedWidgets.appBar(context, category['name']),
                  body: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          SharedFunction.scaleWidth(10, width), 
                          SharedFunction.scaleHeight(19, height), 
                          SharedFunction.scaleWidth(10, width), 
                          SharedFunction.scaleHeight(0, height)
                        ),
                        child: Column(
                          children: [
                            // search bar
                            // category deals
                            categoryDeals(),
                            // top stores
                            topSellers(),
                            // recent stores
                            recentSellers(),
                            // all stores
                            allStores()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            );
        }
      }
      );
  }

  Widget categoryDeals(){
    // 4 deals per row
    return Column(
      children: [
        for (var i = 0; i < category_deals.length; i+=4) ... [
          categoryDealsRow(i),
          SizedBox(height: SharedFunction.scaleHeight(15, height),)
        ]
      ],
    );
  }

  Widget categoryDealsRow(int i){
    List<Widget> row = [];
    // to put size boxes on empty slots in row
    for (var j = i; j < (i + 4); j++) {
      if(j < category_deals.length){
        row.add(categoryDeal(category_deals[j]));
        row.add(SizedBox(width: SharedFunction.scaleWidth(15, width),));
      }else{
        row.add(SizedBox());
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: row,
    );
  }

  Widget categoryDeal(Map categoryDeal){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // image
        categoryDealImage(categoryDeal['image']),
        // space
        SizedBox(height: SharedFunction.scaleHeight(5, height),),
        // name
        categoryDealName(categoryDeal['name'])
      ],
    );
  }

  Widget categoryDealImage(String url){
    return Container(
      width: SharedFunction.scaleWidth(categoryImage, width),
      height: SharedFunction.scaleWidth(categoryImage, width),
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget categoryDealName(String name){
    return Text(name);
  }

  Widget topSellers(){
    print("Top Sellers");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("Top Sellers"),
        // stores sliders
        sellerSliders(context, top_sellers)
      ],
    );
  }

  Widget recentSellers(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("Recent"),
        // stores sliders
        sellerSliders(context, recent_sellers)
      ],
    );
  }

  Widget allStores(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("All Stores"),
        // stores
        for (var seller in all_sellers) ... [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ListOfProducts.routeName, arguments: seller);
            },
            child: SharedWidgets.seller(seller, width, height)
          )
        ]
      ],
    );
  }

  Widget title(String name){
    return Text(
      name,
      style: SharedStyle.title,
    );
  }

  Widget sellerSliders(BuildContext context, List _sellers){
    print(_sellers);
    return Container(
      constraints: BoxConstraints.tightFor(width: double.infinity),
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: SharedFunction.scaleHeight(SharedWidgets.sellerFinalHeight, height),
          viewportFraction: 0.9,
          onPageChanged: (index, reason) {}
        ),
        items: [
          for (var seller in _sellers) ... [
            Padding(
              padding: EdgeInsets.only(right: SharedFunction.scaleWidth(15, width)),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ListOfProducts.routeName, arguments: seller);
                },
                child: SharedWidgets.seller(seller, width, height)
              ),
            )
          ]
        ],
      ),
    );
  }
}