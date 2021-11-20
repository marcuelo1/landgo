import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/models/seller_model.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';
import 'package:landgo_seller/core/widgets/bar_widgets.dart';
import 'package:landgo_seller/features/profile/controllers/profile_controller.dart';
import 'package:provider/provider.dart';

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
  late ProfileController con;

  @override
  void initState(){
    super.initState();
    con =  Provider.of<ProfileController>(context, listen: false);
    con.getProfileData();
  }

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
          child: Consumer<ProfileController>(
            builder: (_, pc, __) {
              return Column(
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
                        pc.seller.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // Name
                  Text("Name"),
                  Text(pc.seller.name),
                  // Address
                  Text("Address"),
                  Text(pc.seller.address),
                  // Phone Number
                  Text("Phone Number"),
                  Text(pc.seller.phoneNumber),
                  // Schedule
                ],
              );
            }
          ),
        ),
      )
    );
  }
}