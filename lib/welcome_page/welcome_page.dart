import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'welcome_page_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomePage extends StatelessWidget {
  final double whiteContainerWidth = 400;
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
    int sliderCount = 1;

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
      height: SharedFunction.heightPercent(context, 46),
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
            print(index);
            print(reason);
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
          constraints: BoxConstraints.tightFor(width: whiteContainerWidth),
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
    return Text("data");
  }
}