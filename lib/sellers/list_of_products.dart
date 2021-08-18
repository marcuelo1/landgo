import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ListOfProducts extends StatefulWidget {
  static const String routeName = "list_of_products";

  @override
  _ListOfProductsState createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/list_of_stores";
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // response
  Map response = {};
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
    final Map seller = ModalRoute.of(context)!.settings.arguments as Map;
    print(seller);
    return PixelPerfect(
      child: Scaffold(
        appBar: SharedWidgets.appBar(""),
        body: Text("list of products"),
      )
    );
  }
}