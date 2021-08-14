import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class SharedWidgets {
  static AppBar appBar(){
    return AppBar(
      title: _appBarTitle(),
      centerTitle: true,
      backgroundColor: SharedStyle.black2,
      iconTheme: IconThemeData(color: SharedStyle.yellow),
      actions: [
        _shoppingCart(),
        SizedBox(width: 20,),
        _search(),
        SizedBox(width: 50,),
      ],
      actionsIconTheme: IconThemeData(color: SharedStyle.yellow),
    );
  }

  static Widget _appBarTitle(){
    return Text(
      "LandGo",
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
}