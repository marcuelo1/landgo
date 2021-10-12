import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/sign_in/sign_in.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar(BuildContext context, {String title = "Landgo"}){

    return AppBar(
      title: _appBarTitle(title),
      centerTitle: true,
      backgroundColor: SharedStyle.black2,
      iconTheme: IconThemeData(color: SharedStyle.yellow),
      actionsIconTheme: IconThemeData(color: SharedStyle.yellow),
    );
  }

  static Widget _appBarTitle(String title){
    return Text(
      title,
      style: SharedStyle.appBarTitle,
    );
  }

  /////////////////////
  /// S I D E  B A R
  /////////////////////
  static List menus = [
    ["Profile", "route", Icon(Icons.person)],
    ["Transactions", "route", Icon(Icons.person)],
    ["Vouchers", "route", Icon(Icons.location_on)],
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

}