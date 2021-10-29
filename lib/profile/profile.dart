import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/error_page.dart';
import 'package:landgo_rider/shared/headers.dart';
import 'package:landgo_rider/shared/loading.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/shared/shared_widgets.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/rider/profile";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;
  
  // variables
  bool refresh = true;
  Map rider = {};

  // headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    return !refresh ? buildContent(context) : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ErrorPage();
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if (snapshot.hasError) {
              return  ErrorPage();
            }
            refresh = false;

            // get response
            var response = snapshot.data;
            var responseBody = response['body'];
            print(responseBody);
            print("============================================================== response body");
            
            rider = responseBody['rider'];

            return buildContent(context);
        }
      }
    );
  }

  Widget buildContent(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        bottomNavigationBar: SharedWidgets.bottomAppBar(context),
        drawer: SharedWidgets.sideBar(context, rider, _headers),
        backgroundColor: SharedStyle.yellow,
        body: Center(
          child: Text("Profile"),
        ),
      )
    );
  }
}