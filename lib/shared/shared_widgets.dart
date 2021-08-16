import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar([String title = "LandGo"]){
    return AppBar(
      title: _appBarTitle(title),
      centerTitle: true,
      backgroundColor: SharedStyle.black2,
      iconTheme: IconThemeData(color: SharedStyle.yellow),
      actions: [
        _shoppingCart(),
        // SizedBox(width: 20,),
        // _search(),
        SizedBox(width: 50,),
      ],
      actionsIconTheme: IconThemeData(color: SharedStyle.yellow),
    );
  }

  static Widget _appBarTitle(String title){
    return Text(
      title,
      style: SharedStyle.appBarTitle,
    );
  }

  static Widget _shoppingCart(){
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.shopping_cart_outlined),
    );
  }

  static Widget _search(){
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.search),
    );
  }

  /////////////////////
  /// S I D E  B A R
  /////////////////////
  static Widget sideBar(){
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

  /////////////////////
  /// P R O D U C T
  /////////////////////
  static final double productHeight = 70;
  static final double productWidth = 327;
  static final double productImageWidth = 70;
  static final double productImageHeight = 70;

  static Widget product(String imageUrl, String name, String price, double width, double height){
    return Column(
      children: [
        _productContent(imageUrl, name, price, width, height),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),)
      ],
    );
  }

  static Widget _productContent(String imageUrl, String name, String price, double width, double height){
    return Container(
      height: SharedFunction.scaleHeight(productHeight, height),
      width: SharedFunction.scaleWidth(productWidth, width),
      child: Row( 
        children: [
          // product image
          productImage(imageUrl, width, height),
          // space
          SizedBox(width: SharedFunction.scaleWidth(21, width),),
          // product details
          _productDetails(name, price),
          // add button
          _productAddBtn()
        ],
      ),
    );
  }

  static Widget productImage(String url, double width, double height){
    return Container(
      width: SharedFunction.scaleWidth(productImageWidth, width),
      height: SharedFunction.scaleHeight(productImageHeight, height),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  static Widget _productDetails(String name, String price){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product name
        _productName(name),
        // product price
        _productPrice(price)
      ],
    );
  }

  static Widget _productName(String name){
    return Text(
      name,
      style: SharedStyle.productName,
    );
  }

  static Widget _productPrice(String price){
    return Text(
      "₱$price",
      style: SharedStyle.productPrice,
    );
  }

  static Widget _productAddBtn(){
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

  /////////////////////
  /// S E L L E R 
  /////////////////////
  static final double sellerWidth = 327;
  static final double sellerHeight = 198;
  static final double sellerFinalHeight = 229;
  static final double sellerImageWidth = 327;
  static final double sellerImageHeight = 125;
  static final double sellerAddressWidth = 232;

  static Widget seller(String url, String name, String address, String rating, double width, double height){
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          // Seller content
          _sellerContent(url, name, address, rating, width, height),
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

  static Widget _sellerContent(String url, String name, String address, String rating, double width, double height){
    return Container(
      width: SharedFunction.scaleWidth(sellerWidth, width),
      height: SharedFunction.scaleHeight(sellerHeight, height),
      child: Column(
        children: [
          // Image
          _sellerImage(url, width, height),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(9, height),),
          // Name and rating
          _sellerNameAndRating(name, rating, width, height),
          // Space
          SizedBox(height: SharedFunction.scaleHeight(5, height),),
          // address
          _sellerAddress(address, width, height)
        ],
      ),
    );
  }

  static Widget _sellerImage(String url, double width, double height){
    return ClipRRect(
      borderRadius: SharedStyle.borderRadius(15, 15, 15, 15),
      child: Container(
        width: SharedFunction.scaleWidth(sellerImageWidth, width),
        height: SharedFunction.scaleHeight(sellerImageHeight, height),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget _sellerNameAndRating(String name, String rating, double width, double height){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _sellerName(name),
        _sellerRating(rating, width, height)
      ],
    );
  }

  static Widget _sellerName(String name){
    return Text(
      name,
      style: SharedStyle.sellerName,
    );
  }

  static Widget _sellerRating(String rating, double width, double height){
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
          style: SharedStyle.sellerRating,
        )
      ],
    );
  }

  static Widget _sellerAddress(String address, double width, double height){
    return Row(
      children: [
        Container(
          width: SharedFunction.scaleWidth(sellerAddressWidth, width),
          child: Text(
            address,
            style: SharedStyle.sellerAddress,
          ),
        )
      ],
    );
  }
}