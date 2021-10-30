import 'package:flutter/material.dart';
import 'package:landgo_rider/history/history.dart';
import 'package:landgo_rider/home/home.dart';
import 'package:landgo_rider/profile/profile.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/sign_in/sign_in.dart';
import 'package:landgo_rider/wallet/wallet.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar(BuildContext context, {String title = "Landgo"}){

    return AppBar(
      title: _appBarTitle(title),
      centerTitle: true,
      backgroundColor: SharedStyle.white,
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
    ["Help Center", "route", Icon(Icons.info_outline)],
    ["Settings", "route", Icon(Icons.settings)],
    ["Terms & Conditions", "route", Icon(Icons.info_outline)],
  ];
  static Map<String, String> headers = {};
  static Widget sideBar(BuildContext context, Map _rider, Map<String, String> _headers){
    headers = _headers;

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        riderName(_rider),
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        for (var menu in menus) ... [
          sideBarMenu(context, menu, _rider)
        ],
        // Divider
        Divider(color: SharedStyle.black,height: 1,),
        logoutBtn(context)
      ],
    );
  }

  static Widget riderName(Map _rider){
    return Container(
      width: double.infinity,
      child: Text(
        _rider['name']
      ),
    );
  }

  static Widget sideBarMenu(BuildContext context, List _menu, Map _rider){
    return ListTile(
      title: Row(
        children: [
          _menu[2],
          SizedBox(width: 10,),
          Text(_menu[0])
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, _menu[1], arguments: _rider);
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
        String rawUrl = "${SharedUrl.root}/${SharedUrl.version}/riders/sign_out";
        
        Map _response = await SharedFunction.sendData(rawUrl, headers, {"email": headers['uid']}, "delete");
        
        
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
  // B O T T O M  B A R
  /////////////////////
  static BottomAppBar bottomAppBar(BuildContext context){
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        width: double.infinity,
        height: 60,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            // Profile
            _bottomAppBarBtn(context, Icon(Icons.person), "Profile", Profile.routeName),
            // Deliveries
            _bottomAppBarBtn(context, Icon(Icons.bike_scooter), "Delivery", Home.routeName),
            // History
            _bottomAppBarBtn(context, Icon(Icons.timer), "History", History.routeName),
            // Wallet
            _bottomAppBarBtn(context, Icon(Icons.account_balance_wallet), "Wallet", Wallet.routeName),
          ]
        ),
      )
    );
  }

  static Widget _bottomAppBarBtn(BuildContext context, Icon _icon, String _name, String _route){
    return GestureDetector(
      onTap: (){
        Navigator.popAndPushNamed(context, _route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _icon,
          Text(
            _name
          )
        ],
      ),
    );
  }
}