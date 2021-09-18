import 'package:flutter/material.dart';
import 'package:ryve_mobile/home/home.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/sign_in/sign_in.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/is_signed_in";

  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("check internet");
          case ConnectionState.waiting: // Retrieving
            return content(context);
          default: // Success of connecting to back end
            var response = snapshot.data;
            print(response);
            print("====================");
            // check status of response
            if (response['status'] == 200) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Home()
                ), 
                (route) => false
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn()
                ), 
                (route) => false
              );
            }

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Text("Splash"),
      )
    );
  }
}