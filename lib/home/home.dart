import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/home/home_style.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double imageWidth = 150;
  final double imageHeight = 100;
  final double productHeight = 70;
  final double productWidth = 327;
  final double productImageWidth = 70;
  final double productImageHeight = 70;
  final double sellerWidth = 327;
  final double sellerHeight = 198;
  final double sellerImageWidth = 327;
  final double sellerImageHeight = 125;
  final double sellerAddressWidth = 232;

  // categories
  List categories = [
    ["Food", "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"],
    ["Services", "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"],
    ["Grocery", "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"],
    ["Hardware", "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"],
    ["Pharmacy", "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg"],
  ];

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

  Map _headers = {};

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
    
    return PixelPerfect(
      scale: scale,
      child: SafeArea(
        child: Scaffold(
          appBar: appBar(),
          drawer: Drawer(
            child: sideBar(),
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

  Widget sideBar(){
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }

  AppBar appBar(){
    return AppBar(
      title: appBarTitle(),
      centerTitle: true,
      backgroundColor: SharedStyle.black2,
      iconTheme: IconThemeData(color: SharedStyle.yellow),
      actions: [
        shoppingCart(),
        SizedBox(width: 20,),
        search(),
        SizedBox(width: 50,),
      ],
      actionsIconTheme: IconThemeData(color: SharedStyle.yellow),
    );
  }

  Widget appBarTitle(){
    return Text(
      "LandGo",
      style: HomeStyle.appBarTitle,
    );
  }

  Widget shoppingCart(){
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.shopping_cart_outlined),
    );
  }

  Widget search(){
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.search),
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
    List category1;
    List category2;
    
    if(i+1 == categories.length){ // categtories count is odd numbers
      category1 = categories[i];
      category2 = [];
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

  Widget categoryContent(List category){
    if(category.isEmpty){
      return Stack(children: [SizedBox()],);  // empty
    }

    return GestureDetector(
      onTap: (){},
      child: Stack(
        children: [
          // image
          categoryImage(category[1]),
          // yellow overlay
          yellowOverlay(),
          //black overlay
          blackOverlay(),
          // text
          categoryName(category[0])
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
          product(item[0], item[1], item[2].toStringAsFixed(2))
        ]
      ],
    );  
  }

  Widget product(String imageUrl, String name, String price){
    return Column(
      children: [
        productContent(imageUrl, name, price),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),)
      ],
    );
  }

  Widget productContent(String imageUrl, String name, String price){
    return Container(
      height: SharedFunction.scaleHeight(productHeight, height),
      width: SharedFunction.scaleWidth(productWidth, width),
      child: Row( 
        children: [
          // product image
          productImage(imageUrl),
          // space
          SizedBox(width: SharedFunction.scaleWidth(21, width),),
          // product details
          productDetails(name, price),
          // add button
          productAddBtn()
        ],
      ),
    );
  }

  Widget productImage(String url){
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget productDetails(String name, String price){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product name
        productName(name),
        // product price
        productPrice(price)
      ],
    );
  }

  Widget productName(String name){
    return Text(
      name,
      style: HomeStyle.productName,
    );
  }

  Widget productPrice(String price){
    return Text(
      "₱$price",
      style: HomeStyle.productPrice,
    );
  }

  Widget productAddBtn(){
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: (){},
          child: Icon(
            Icons.add_circle_outline,
            size: 35,
            color: SharedStyle.yellow,
          ),
        ),
      )
    );
  }

  Widget topSellers(){
    return Column(
      children: [
        for (var store in sellers) ... [
          seller(store[0], store[1], store[3], store[2].toStringAsFixed(1))
        ]
      ],
    );
  }

  Widget seller(String url, String name, String address, String rating){
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          // Seller content
          sellerContent(url, name, address, rating),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(10, height),),
          // Divider
          Divider(color: SharedStyle.black,height: 1,),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(20, height),)
        ],
      ),
    );
  }

  Widget sellerContent(String url, String name, String address, String rating){
    return Container(
      width: SharedFunction.scaleWidth(sellerWidth, width),
      height: SharedFunction.scaleHeight(sellerHeight, height),
      child: Column(
        children: [
          // Image
          sellerImage(url),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(9, height),),
          // Name and rating
          sellerNameAndRating(name, rating),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(5, height),),
          // address
          sellerAddress(address)
        ],
      ),
    );
  }

  Widget sellerImage(String url){
    return ClipRRect(
      borderRadius: SharedStyle.borderRadius(15, 15, 15, 15),
      child: Container(
        width: SharedFunction.scaleWidth(sellerImageWidth, width),
        height: SharedFunction.scaleHeight(sellerImageHeight, height),
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget sellerNameAndRating(String name, String rating){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sellerName(name),
        sellerRating(rating)
      ],
    );
  }

  Widget sellerName(String name){
    return Text(
      name,
      style: HomeStyle.sellerName,
    );
  }

  Widget sellerRating(String rating){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // star icon
        Icon(
          Icons.star_rounded,
          size: 20,
          color: SharedStyle.yellow,
        ),
        // space
        SizedBox(width: SharedFunction.scaleWidth(5, width),),
        // rating
        Text(
          rating,
          style: HomeStyle.sellerRating,
        )
      ],
    );
  }

  Widget sellerAddress(String address){
    return Row(
      children: [
        Container(
          width: SharedFunction.scaleWidth(sellerAddressWidth, width),
          child: Text(
            address,
            style: HomeStyle.sellerAddress,
          ),
        )
      ],
    );
  }
}