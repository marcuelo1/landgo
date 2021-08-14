import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
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

  /////////////////////
  /// S I D E  B A R
  /// /////////////////
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
}