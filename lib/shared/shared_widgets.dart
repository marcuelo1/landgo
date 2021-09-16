import 'package:flutter/material.dart';
import 'package:ryve_mobile/cart/cart.dart';
import 'package:ryve_mobile/locations/list_of_locations.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/sidebar/profile.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar(BuildContext context, [String title = "LandGo"]){
    return AppBar(
      title: _appBarTitle(title),
      centerTitle: true,
      backgroundColor: SharedStyle.black2,
      iconTheme: IconThemeData(color: SharedStyle.yellow),
      actions: [
        _locations(context),
        SizedBox(width: 10,),
        _shoppingCart(context),
        // _search(),
        SizedBox(width: 10,),
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

  static Widget _shoppingCart(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Cart.routeName);
      },
      child: Icon(Icons.shopping_cart_outlined),
    );
  }

  static Widget _search(){
    return GestureDetector(
      onTap: (){},
      child: Icon(Icons.search),
    );
  }

  static Widget _locations(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ListOfLocations.routeName);
      },
      child: Icon(Icons.location_on_outlined),
    );
  }

  /////////////////////
  /// S I D E  B A R
  /////////////////////
  static List menus = [
    ["Profile", Profile.routeName, Icon(Icons.person)],
    ["Transactions", "route", Icon(Icons.person)],
    ["Addresses", "route", Icon(Icons.location_on)],
    ["Invite Friends", "route", Icon(Icons.groups)],
    ["Settings", "route", Icon(Icons.settings)],
    ["Help Center", "route", Icon(Icons.info_outline)],
    ["Terms & Conditions", "route", Icon(Icons.info_outline)],
  ];
  static Widget sideBar(BuildContext context, Map _buyer){
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        buyerName(_buyer),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        for (var menu in menus) ... [
          sideBarMenu(context, menu, _buyer)
        ]
      ],
    );
  }

  static Widget buyerName(Map _buyer){
    return Container(
      width: double.infinity,
      child: Text(
        _buyer['name']
      ),
    );
  }

  static Widget sideBarMenu(BuildContext context, List _menu, Map _buyer){
    return ListTile(
      title: Row(
        children: [
          _menu[2],
          SizedBox(width: 10,),
          Text(_menu[0])
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, _menu[1], arguments: _buyer);
      },
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
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // product
        _productContent(imageUrl, name, price, width, height),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
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
        child: Icon(
          Icons.add_circle_outline,
          size: 35,
          color: SharedStyle.yellow,
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

  static Widget seller(Map seller, double width, double height){
    String url = seller['image'];
    String name = seller['name'];
    String address = seller['address'];
    String rating = seller['rating'].toStringAsFixed(1);

    return Column(
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
    );
  }

  static Widget _sellerContent(String url, String name, String address, String rating, double width, double height){
    return Container(
      width: SharedFunction.scaleWidth(sellerWidth, width),
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