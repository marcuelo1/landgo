import 'package:flutter/material.dart';
import 'package:landgo_seller/shared/shared_function.dart';
import 'package:landgo_seller/shared/shared_style.dart';
import 'package:landgo_seller/shared/shared_url.dart';
import 'package:landgo_seller/sign_in/sign_in.dart';

class SharedWidgets {
  /////////////////////
  /// A P P  B A R
  /// /////////////////
  static AppBar appBar(BuildContext context, {String title = "", iconThemeColor}){
    if(iconThemeColor == null){
      iconThemeColor = SharedStyle.red;
    }

    return AppBar(
      title: Row(
        children: [
          if(title != "")...[
            _appBarTitle(title)
          ]
        ],
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: iconThemeColor),
      titleSpacing: 0,
      elevation: 0,
      actions: [],
      actionsIconTheme: IconThemeData(color: iconThemeColor),
    );
  }

  static Widget _appBarTitle(String title){
    return Text(
      title,
      style: SharedStyle.appBarBlackTitle,
    );
  }

  /////////////////////
  /// S I D E  B A R
  /////////////////////
  static List menus = [
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
  // B O T T O M  B A R
  /////////////////////
  static double bottomAppBarHeight = 60;
  static BottomAppBar bottomAppBar(BuildContext context){
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        width: double.infinity,
        height: bottomAppBarHeight,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            // Profile
            _bottomAppBarBtn(context, Icon(Icons.person), "Profile", ""),
            // Deliveries
            _bottomAppBarBtn(context, Icon(Icons.bike_scooter), "Delivery", ""),
            // History
            _bottomAppBarBtn(context, Icon(Icons.timer), "History", ""),
            // Wallet
            _bottomAppBarBtn(context, Icon(Icons.account_balance_wallet), "Wallet", ""),
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

  // BUTTONS
  static Widget redBtn({required void Function()onPressed, String name = "", double width = 0, double height = 0}){
    return Container(
      decoration: SharedStyle.btnContainerDecor,
      child: ElevatedButton(
        onPressed: onPressed, 
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

  static Widget card({required double cardWidth, required double referenceWidth, required Widget child}){
    return Container(
      width: SharedFunction.scaleWidth(cardWidth, referenceWidth),
      decoration: BoxDecoration(
        borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
        color: SharedStyle.white,
      ),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}