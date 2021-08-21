import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/home/home_style.dart';
import 'package:ryve_mobile/sellers/sellers.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'dart:convert';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/home_page";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double imageWidth = 150;
  final double imageHeight = 100;

  // categories
  late List categories;

  // products
  List products = [
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Matcha Pearl",
      79.00,
    ],
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Assorted Meal",
      180.00
    ]
  ];

  // sellers
  List sellers = [
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Shed Twenty Three",
      4.8,
      'Hilado-Rizal Street 6100'
    ],
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Shed Twenty Three",
      4.8,
      'Hilado-Rizal Street 6100 Bacolod City, Villamonte'
    ],
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Shed Twenty Three",
      4.8,
      'Hilado-Rizal Street 6100 Bacolod City, Villamonte'
    ],
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Shed Twenty Three",
      4.8,
      'Hilado-Rizal Street 6100 Bacolod City, Villamonte'
    ],
    [
      "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
      "Shed Twenty Three",
      4.8,
      'Hilado-Rizal Street 6100 Bacolod City, Villamonte'
    ]
  ];

  Map<String,String> _headers = {};
  Map response = {};

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
            }else{
              response = snapshot.data;
              // check status of response
              Map responseBody = response['body'];
              categories = json.decode(responseBody['categories']);
              
              return PixelPerfect(
                scale: scale,
                child: SafeArea(
                  child: Scaffold(
                    appBar: SharedWidgets.appBar(),
                    drawer: Drawer(
                      child: SharedWidgets.sideBar(),
                    ),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(color: SharedStyle.yellow),
                      child: Stack(
                        children: [
                          // static page
                          staticPage(),
                          // draggable page
                          draggablePage()
                        ],
                      ),
                    ),
                  ),
                )
              );
            }
        }
      }
    ); 
  }

  Widget staticPage(){
    return Padding(
      padding: EdgeInsets.fromLTRB(
        SharedFunction.scaleWidth(24, width), 
        SharedFunction.scaleHeight(19, height), 
        SharedFunction.scaleWidth(24, width), 
        SharedFunction.scaleHeight(0, height)
      ),
      child: Column(
        children: [
          // title
          title("Categories"),
          // space
          SizedBox(height: 43,),
          // category list
          for (var i = 0; i < categories.length; i+=2) ... [
            categoryRow(i),
            SizedBox(height: SharedFunction.scaleHeight(15, height),)
          ]
        ],
      ),
    );
  }

  Widget title(String title){
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: HomeStyle.title,
      ),
    );
  }

  Widget categoryRow(int i){
    Map category1;
    Map category2;
    print(categories);
    print(categories[i]);
    if(i+1 == categories.length){ // categtories count is odd numbers
      category1 = categories[i];
      category2 = {};
    }else{  // categories count is even number
      category1 = categories[i];
      category2 = categories[i+1];
    }
    return Row(
      children: [
        categoryContent(category1),
        //space
        SizedBox(width: SharedFunction.scaleWidth(27, width),),
        categoryContent(category2),
      ],
    );
  }

  Widget categoryContent(Map category){
    if(category.isEmpty){
      return Stack(children: [SizedBox()],);  // empty
    }

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Sellers.routeName, arguments: {'id': category['id'], 'name': "${category['name']} Delivery"});
      },
      child: Stack(
        children: [
          // image
          categoryImage(category['image']),
          // yellow overlay
          yellowOverlay(),
          //black overlay
          blackOverlay(),
          // text
          categoryName(category['name'])
        ],
      ),
    );
  }

  Widget categoryImage(String url){
    return ClipRRect(
      borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
      child: Container(
        width: SharedFunction.scaleWidth(imageWidth, width),
        height: SharedFunction.scaleHeight(imageHeight, height),
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget yellowOverlay(){
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: SharedFunction.scaleWidth(imageWidth, width),
        height: SharedFunction.scaleHeight(imageHeight, height),
        decoration: HomeStyle.yellowOverlay,
      ),
    );
  }

  Widget blackOverlay(){
    return Opacity(
      opacity: 0.3,
      child: Container(
        width: SharedFunction.scaleWidth(imageWidth, width),
        height: SharedFunction.scaleHeight(imageHeight, height),
        decoration: HomeStyle.blackOverlay,
      ),
    );
  }

  Widget categoryName(String name){
    return Container(
      width: SharedFunction.scaleWidth(imageWidth, width),
      height: SharedFunction.scaleHeight(imageHeight, height),
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 16, bottom: 7),
      child: Text(
        name,
        style: HomeStyle.categoryName,
      ),
    );
  }

  Widget draggablePage(){
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.3,
      builder: (BuildContext context, ScrollController scrollController){
        return Container(
          decoration: HomeStyle.draggablePage,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              SharedFunction.scaleWidth(24, width), 
              SharedFunction.scaleHeight(0, height), 
              SharedFunction.scaleWidth(24, width), 
              SharedFunction.scaleHeight(0, height)
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  // space
                  SizedBox(height: SharedFunction.scaleHeight(39, height),),
                  // title buy again (should not be displayed if there is no recent orders)
                  title("Buy Again"),
                  // space
                  SizedBox(height: SharedFunction.scaleHeight(18, height),),
                  // top 2 recent purchased
                  recentPurchases(),
                  // title Top Sellers
                  title("Top Sellers"),
                  // space
                  SizedBox(height: SharedFunction.scaleHeight(21, height),),
                  // top 5 sellers
                  topSellers()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget recentPurchases(){
    return Column(
      children: [
        for (var item in products) ... [
          SharedWidgets.product(item[0], item[1], item[2].toStringAsFixed(2), width, height)
        ]
      ],
    );  
  }

  Widget topSellers(){
    return Column(
      children: [
        for (var store in sellers) ... [
          SharedWidgets.seller(store[0], store[1], store[3], store[2].toStringAsFixed(1), width, height)
        ]
      ],
    );
  }
}