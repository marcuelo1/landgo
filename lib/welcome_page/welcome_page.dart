import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'welcome_page_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final double whiteContainerWidth = 375;
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
    return SafeArea(
      child: Scaffold(
        body: Container( /// BACKGROUND
          decoration: BoxDecoration(
            color: SharedStyle.yellow
          ),
          height: double.infinity,
          width: double.infinity,
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
    );
  }

  Widget whiteContainer(context){
    return Container(
      width: whiteContainerWidth,
      margin: EdgeInsets.only(top: 100),
      height: 376,
      padding: EdgeInsets.only(top: 50),
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
          height: 305,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              sliderCount = index;
            });
          }
        ),
        items: sliderItems.map((sliderItem) => sliderContent(context, sliderItem)).toList(),
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
                  child: 
                    Container(
                      constraints: BoxConstraints.tightFor(width: 255, height: 175),
                      child: Image.network(url, fit: BoxFit.fill,),
                    ),
                ),
                // TITLE
                Container(
                  width: whiteContainerWidth,
                  margin: EdgeInsets.fromLTRB(36, 30, 75, 2),
                  child: Text(
                    title,
                    style: WelcomePageStyle.title,
                  ),
                ),
                // CAPTION
                Container(
                  width: whiteContainerWidth,
                  margin: EdgeInsets.fromLTRB(36, 2, 75, 20),
                  child: Text(
                    caption,
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
      onPressed: () { },
      child: Container(
        width: 300,
        height: 60,
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
      margin: EdgeInsets.only(bottom: 48),
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