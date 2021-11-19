import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;
    
    return SafeArea(
      child: Scaffold(
        appBar: BarWidgets.appBar(context),
        bottomNavigationBar: BarWidgets.bottomAppBar(context),
        backgroundColor: SharedStyle.red,
        body: Padding(
          padding: EdgeInsets.only(left: StyleFunction.scaleWidth(24, width), right: StyleFunction.scaleWidth(24, width)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Profile"),
              // Seller Image with change Image
              Container(
                width: StyleFunction.scaleWidth(327, width),
                height: StyleFunction.scaleHeight(200, height),
                child: ClipRRect(
                  borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
                  child: Image.network(
                    "",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // Name
              Text("Name"),
              Text("Jollibee"),
              // Address
              Text("Address"),
              Text("Brgy. Canduman, Mandaue City"),
              // Phone Number
              Text("Phone Number"),
              Text("09053536495")
              // Schedule
            ],
          ),
        ),
      )
    );
  }
}