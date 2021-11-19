import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/sellers/show_seller.dart';
import 'package:ryve_mobile/core/widgets/error_page.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/core/widgets/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';

class SearchResults extends StatefulWidget {
  static const String routeName = "search_results";

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/search";
  
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  String keyword = "";
  bool refresh = true;
  List sellers = [];

  // Headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }
  
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    keyword = args["keyword"];
    String _rawUrl = _dataUrl + "?keyword=$keyword";

    return !refresh ? content(context) : FutureBuilder(
      future: SharedFunction.getData(_rawUrl, _headers),
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

            sellers = responseBody['sellers'];

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var _seller in sellers) ... [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ShowSeller.routeName, arguments: _seller);
                  },
                  child: SharedWidgets.seller(_seller, width, height),
                )
              ]
            ],
          ),
        ),
      )
    );
  }
}