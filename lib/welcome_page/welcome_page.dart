import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/sign_in/sign_in.dart';
import 'package:ryve_mobile/sign_up/sign_up.dart';
import 'welcome_page_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "/";
  
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final double whiteContainerWidth = 375;
  final double whiteContainerHeight = 376;
  final double sliderHeight = 317; // with slider indicator
  final double imageWidth = 255;
  final double imageHeight = 175;
  final double joinRyveBtnWidth = 300;
  final double joinRyveBtnHeight = 60;
  late double scale;
  late double width;
  late double height;
  int sliderCount = 0;
  final List <Map> sliderItems = [
    // First Slide Item
    {
      'url': 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
      'title': 'Welcome to Ryve!',
      'caption': 'Your online one-stop shop for food, groceries, and more.'
    },
    // Second Slide Item
    {
      'url': 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
      'title': 'Welcome to Ryve!',
      'caption': 'Your online one-stop shop for food, groceries, and more.'
    },
    // Third Slide Item
    {
      'url': 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
      'title': 'Welcome to Ryve!',
      'caption': 'Your online one-stop shop for food, groceries, and more.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;
    
    return PixelPerfect(
      scale: scale,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(7.5, 4.5, 7.5, 0),
            decoration: BoxDecoration(
              color: SharedStyle.yellow
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  /// WHITE CONTAINER
                  whiteContainer(context),
                  /// CONTENT
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// SLIDERS
                      sliders(context),
                      /// SLIDERS INDICATOR
                      sliderIndicator(context),
                      /// JOIN RYVE
                      joinRyve(context),
                      /// ALREADY REGISTERED
                      signIn(context)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
    // return SafeArea(
    //   child: Scaffold(
    //     body: Container( /// BACKGROUND
    //       decoration: BoxDecoration(
    //         color: SharedStyle.yellow
    //       ),
    //       height: double.infinity,
    //       width: double.infinity,
    //       child: Align( 
    //         alignment: Alignment.bottomCenter,
    //         child: Stack(
    //           children: [
    //             /// WHITE CONTAINER
    //             whiteContainer(context),
    //             /// CONTENT
    //             Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 /// SLIDERS
    //                 sliders(context),
    //                 /// SLIDERS INDICATOR
    //                 sliderIndicator(context),
    //                 /// JOIN RYVE
    //                 joinRyve(context),
    //                 /// ALREADY REGISTERED
    //                 signIn(context)
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget whiteContainer(context){
    return Container(
      width: whiteContainerWidth,
      height: whiteContainerHeight,
      margin: EdgeInsets.only(top: SharedFunction.scaleHeight(100, height)),
      decoration: BoxDecoration(
        borderRadius: SharedStyle.borderRadius(20, 20, 0, 0),
        color: Colors.white,
      ),
    );
  }

  Widget sliders(context){
    return Container(
      constraints: BoxConstraints.tightFor(width: whiteContainerWidth),
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: sliderHeight,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              sliderCount = index;
            });
          }
        ),
        items: [
          for (var sliderItem in sliderItems) ... [
            sliderContent(context, sliderItem)
          ]
        ],
      ),
    );
  }

  Widget sliderContent(context, sliderItem){
    String url = sliderItem['url'];
    String title = sliderItem['title'];
    String caption = sliderItem['caption'];

    return Builder(
      builder: (BuildContext context){
        return Container(
          width: whiteContainerWidth,
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.
              center,
              children: [
                // IMAGE
                ClipRRect(
                  borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
                  child: Image.network(
                    url,
                    width: SharedFunction.scaleWidth(imageWidth, width),
                    height: SharedFunction.scaleHeight(imageHeight, height),
                  ),
                ),
                // TITLE
                Container(
                  width: whiteContainerWidth,
                  margin: EdgeInsets.fromLTRB(
                    SharedFunction.scaleWidth(35, width), 
                    SharedFunction.scaleHeight(30, height), 
                    SharedFunction.scaleWidth(36, width), 
                    SharedFunction.scaleHeight(2, height)
                  ),
                  child: Text(
                    title,
                    textScaleFactor: SharedFunction.textScale(width),
                    style: WelcomePageStyle.title,
                  ),
                ),
                // CAPTION
                Container(
                  width: whiteContainerWidth,
                  margin: EdgeInsets.fromLTRB(
                    SharedFunction.scaleWidth(36, width), 
                    SharedFunction.scaleHeight(0, height), 
                    SharedFunction.scaleWidth(36, width), 
                    SharedFunction.scaleHeight(20, height)
                  ),
                  child: Text(
                    caption,
                    textScaleFactor: SharedFunction.textScale(width),
                    style: WelcomePageStyle.caption,
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  Widget sliderIndicator(context){
    List <Widget> indicator = [];

    switch (sliderCount) {
      case 0:
        indicator = [
          sliderDot(true),
          sliderDot(false),
          sliderDot(false),
        ];
        break;
      case 1:
        indicator = [
          sliderDot(false),
          sliderDot(true),
          sliderDot(false),
        ];
        break;
      case 2:
        indicator = [
          sliderDot(false),
          sliderDot(false),
          sliderDot(true),
        ];
        break;
    }
    return Container(
      width: whiteContainerWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: indicator,
      ),
    );
  }

  Widget sliderDot(bool active){
    if (active) {
      return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Icon(Icons.circle, size: 7, color: SharedStyle.selectedDot,),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Icon(Icons.circle, size: 7, color: SharedStyle.unselectedDot,),
      );
    }
  }

  Widget joinRyve(context){
    return TextButton(
      onPressed: () { 
        Navigator.pushNamed(context, SignUp.routeName);
      },
      child: Container(
        width: joinRyveBtnWidth,
        height: joinRyveBtnHeight,
        margin: EdgeInsets.only(top: 13, bottom: 11),
        decoration: WelcomePageStyle.joinRyveBtn,
        child: Center(
          child: Text(
            "Join Ryve",
            style: WelcomePageStyle.joinRyveText,
          ),
        ),
      ),
    );
  }

  Widget signIn(context){
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already registered? ",
            style: WelcomePageStyle.regularText,
          ),
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, SignIn.routeName);
            }, 
            child: Text(
              "Sign in.",
              style: WelcomePageStyle.yellowText,
            ),
          ),
        ],
      ),
    );
  }
}