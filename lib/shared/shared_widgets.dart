import 'package:flutter/material.dart';
import 'package:ryve_mobile/cart/cart.dart';
import 'package:ryve_mobile/locations/list_of_locations.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/sidebar/list_of_transactions.dart';
import 'package:ryve_mobile/sidebar/list_of_vouchers.dart';
import 'package:ryve_mobile/sidebar/profile.dart';
import 'package:ryve_mobile/sign_in/sign_in.dart';
import 'package:ryve_mobile/transactions/current_transactions.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar(BuildContext context, {String title = "", String locName = "", String locDescription = "", bool showCurrTrans = false, bool showLoc = false, bool showCart = false}){

    return AppBar(
      title: Row(
        children: [
          if(title != "")...[
            _appBarTitle(title)
          ],
          if (showLoc) ... [
            _locations(context, locName, locDescription),
          ],
        ],
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: SharedStyle.red),
      titleSpacing: 0,
      elevation: 0,
      actions: [
        if (showCurrTrans) ... [
          _currentTransactions(context),
          SizedBox(width: 10,),
        ],
        if (showCart) ... [
          _shoppingCart(context),
          SizedBox(width: 10,),
        ]
      ],
      actionsIconTheme: IconThemeData(color: SharedStyle.red),
    );
  }

  static Widget _appBarTitle(String title){
    return Text(
      title,
      style: SharedStyle.appBarBlackTitle,
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

  static Widget _locations(BuildContext context, name, description){
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, ListOfLocations.routeName), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            name,
            style: SharedStyle.appBarTitle,
          ),
          Container(
            width: 200,
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: SharedStyle.appBarSubTitle
            ),
          ),
        ],
      )
    );
  }

  static Widget _currentTransactions(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, CurrentTransactions.routeName);
      },
      child: Icon(Icons.receipt),
    );
  }

  /////////////////////
  /// S I D E  B A R
  /////////////////////
  static List menus = [
    ["Profile", Profile.routeName, Icon(Icons.person)],
    ["Transactions", ListOfTransactions.routeName, Icon(Icons.person)],
    ["Vouchers", ListOfVouchers.routeName, Icon(Icons.location_on)],
    ["Addresses", "route", Icon(Icons.location_on)],
    ["Invite Friends", "route", Icon(Icons.groups)],
    ["Settings", "route", Icon(Icons.settings)],
    ["Help Center", "route", Icon(Icons.info_outline)],
    ["Terms & Conditions", "route", Icon(Icons.info_outline)],
  ];
  static Map<String, String> headers = {};
  static Widget sideBar(BuildContext context, Map _buyer, Map<String, String> _headers){
    headers = _headers;

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        buyerName(_buyer),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        for (var menu in menus) ... [
          sideBarMenu(context, menu, _buyer)
        ],
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        logoutBtn(context)
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

  static Widget logoutBtn(BuildContext context){
    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.logout
          ),
          SizedBox(width: 10,),
          Text("Logout")
        ],
      ),
      onTap: () async {
        String rawUrl = "${SharedUrl.root}/${SharedUrl.version}/buyers/sign_out";
        
        Map _response = await SharedFunction.sendData(rawUrl, headers, {}, "delete");
        
        
        if (_response['status'] == 200) {
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context) => SignIn()
            ), 
            (route) => false
          );
        }
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

  static Widget product(Map product, double width, double height){
    return Column(
      children: [
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // product
        _productContent(product, width, height),
        // Space
        SizedBox(height: SharedFunction.scaleHeight(15, height),),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
      ],
    );
  }

  static Widget _productContent(Map product, double width, double height){
    return Container(
      height: SharedFunction.scaleHeight(productHeight, height),
      width: SharedFunction.scaleWidth(productWidth, width),
      child: Row( 
        children: [
          // product image
          productImage(product['image'], width, height),
          // space
          SizedBox(width: SharedFunction.scaleWidth(21, width),),
          // product details
          _productDetails(product, width),
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

  static Widget _productDetails(Map product, double width){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product name
        _productName(product['name']),
        // product description
        _productDescription(product['description'], width),
        // product price
        _productPrice(product['price'], product['base_price'], width)
      ],
    );
  }

  static Widget _productName(String name){
    return Text(
      name,
      style: SharedStyle.productName,
    );
  }

  static Widget _productPrice(double price, double basePrice, double width){
    bool _isSame = price == basePrice;
    String _stringPrice = price.toStringAsFixed(2);
    String _stringBasePrice = basePrice.toStringAsFixed(2);

    return Row(
      children: [
        Text(
          "₱$_stringBasePrice",
          style: _isSame ? SharedStyle.productPrice : SharedStyle.productPriceLineThrough,
        ),
        if(!_isSame) ... [
          SizedBox(width: SharedFunction.scaleWidth(10, width)),
          Text(
            "₱$_stringPrice",
            style: SharedStyle.productPrice,
          )
        ]
      ],
    );
  }

  static Widget _productDescription(String _description, double width){
    return Container(
      width: SharedFunction.scaleWidth(230, width),
      child: Text(
        _description,
        overflow: TextOverflow.ellipsis,
        style: SharedStyle.productPrice,
      ),
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

  /////////////////////
  /// V O U C H E R
  /////////////////////
  static final double voucherWidth = 200;
  static final double voucherHeight = 60;

  static Widget voucher(Map _voucher, double width, double height){
    return Container(
      width: SharedFunction.scaleWidth(voucherWidth, width),
      height: SharedFunction.scaleHeight(voucherHeight, height),
      color: SharedStyle.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_voucher['code']),
          Text(_voucher['description'])
        ],
      ),
    );
  }


  // BUTTONS
  static Widget redBtn(Function()function, String name, double width, double height){
    return Container(
      decoration: SharedStyle.btnContainerDecor,
      child: ElevatedButton(
        onPressed: function, 
        style: SharedStyle.redBtn,
        child: Container(
          width: SharedFunction.scaleWidth(SharedStyle.btnWidth, width),
          height: SharedFunction.scaleHeight(SharedStyle.btnHeight, height),
          child: Center(
            child: Text(
              name,
              style: SharedStyle.redBtnText,
            ),
          ),
        )
      ),
    );
  }

  static Widget whiteBtn(Function()function, String name, double width, double height){
    return Container(
      decoration: SharedStyle.btnContainerDecor,
      child: ElevatedButton(
        onPressed: function, 
        style: SharedStyle.whiteBtn,
        child: Container(
          width: SharedFunction.scaleWidth(SharedStyle.btnWidth, width),
          height: SharedFunction.scaleHeight(SharedStyle.btnHeight, height),
          child: Center(
            child: Text(
              name,
              style: SharedStyle.whiteBtnText,
            ),
          ),
        )
      ),
    );
  }
}