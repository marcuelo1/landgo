import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class Sellers extends StatefulWidget {
  static const String routeName = "sellers";
  
  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // category deals
  List<Map> category_deals = [
    {
      "id": 1,
      "name": "50%",
      "image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
    },
    {
      "id": 2,
      "name": "20%",
      "image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
    },
    {
      "id": 2,
      "name": "20%",
      "image": "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    final Map categeory = ModalRoute.of(context)!.settings.arguments as Map;
    print(categeory);
    return PixelPerfect(
      child: SafeArea(
        child: Scaffold(
          body: Scaffold(
            appBar: SharedWidgets.appBar(categeory['name']),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    SharedFunction.scaleWidth(24, width), 
                    SharedFunction.scaleHeight(19, height), 
                    SharedFunction.scaleWidth(24, width), 
                    SharedFunction.scaleHeight(0, height)
                  ),
                  child: Column(
                    children: [
                      // search bar
                      Text("data")
                      // category deals
                      // top stores
                      // recent stores
                      // all stores
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      )
    );
  }

  Widget categoryDeals(){
    return Container(

    );
  }
}