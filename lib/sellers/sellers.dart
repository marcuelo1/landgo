import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
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

  // sellers
  List sellers = [
    {
      "id": 1,
      "background_image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "company_name": "Shed Twenty Three",
      "rating": 4.8,
      "location": "Hilado-Rizal Street 6100 Bacolod City, Villamonte"
    },
    {
      "id": 1,
      "background_image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "company_name": "Shed Twenty Three",
      "rating": 4.8,
      "location": "Hilado-Rizal Street 6100 Bacolod City, Villamonte"
    },
    {
      "id": 1,
      "background_image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "company_name": "Shed Twenty Three",
      "rating": 4.8,
      "location": "Hilado-Rizal Street 6100 Bacolod City, Villamonte"
    },
    {
      "id": 1,
      "background_image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "company_name": "Shed Twenty Three",
      "rating": 4.8,
      "location": "Hilado-Rizal Street 6100 Bacolod City, Villamonte"
    },
    {
      "id": 1,
      "background_image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "company_name": "Shed Twenty Three",
      "rating": 4.8,
      "location": "Hilado-Rizal Street 6100 Bacolod City, Villamonte"
    }
  ];

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
    _dataUrl = _dataUrl + "?id=${category['id']}";
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
            if(responseBody['category_deals'].length > 0){
              category_deals = json.decode(responseBody['category_deals']);
            }

            return PixelPerfect(
              child: SafeArea(
                child: Scaffold(
                  body: Scaffold(
                    appBar: SharedWidgets.appBar(category['name']),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // title
        title("Top Sellers"),
        // stores sliders
        sellerSliders(context, sellers)
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
        sellerSliders(context, sellers)
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
        for (var seller in sellers) ... [
          SharedWidgets.seller(seller['background_image'], seller['company_name'], seller['location'], seller['rating'].toStringAsFixed(1), width, height)
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

  Widget sellerSliders(BuildContext context, List sellers){
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
          for (var seller in sellers) ... [
            Padding(
              padding: EdgeInsets.only(right: SharedFunction.scaleWidth(15, width)),
              child: SharedWidgets.seller(seller['background_image'], seller['company_name'], seller['location'], seller['rating'].toStringAsFixed(1), width, height),
            )
          ]
        ],
      ),
    );
  }
}