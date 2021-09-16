import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  Map _buyer = {};

  // headers 
  Map<String,String> _headers = {};
  Map response = {};

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

    _buyer = ModalRoute.of(context)!.settings.arguments as Map;

    print(_buyer);
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, "Profile"),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(0, height)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

            ],
          ),
        )
      )
    );
  }

  Widget name(Map _buyer){
    return Container(

    );
  }
}