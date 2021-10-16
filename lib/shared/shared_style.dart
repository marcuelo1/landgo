import 'package:flutter/material.dart';
import 'shared_function.dart';

class SharedStyle {
  static final double referenceWidth = 375;
  static final double referenceHeight = 812;
  // Check ryve prototype colors first row (from left to right)
  static final Color lightyellow = SharedFunction.hexToColor("F7F052");
  static final Color yellow = SharedFunction.hexToColor("F2D450");
  static final Color darkyellow = SharedFunction.hexToColor("B79332");
  static final Color brown = SharedFunction.hexToColor("F7F052");
  static final Color darkbrown = SharedFunction.hexToColor("F7F052");

  // Shades of black, check ryve prototype colors (from left to right) 
  // Note: some of the colors are the same
  static final Color white2 = SharedFunction.hexToColor("#EFEFF4");
  static final Color black2 = SharedFunction.hexToColor("1C1C1E");
  static final Color black3 = SharedFunction.hexToColor("2C2C2E");
  static final Color black4 = SharedFunction.hexToColor("3A3A3C");

  // Labels
  static final Color primaryText = SharedFunction.hexToColor("000000").withOpacity(0.96);
  static final Color secondaryText = SharedFunction.hexToColor("000000").withOpacity(0.5);
  static final Color tertiaryText = SharedFunction.hexToColor("B2B2B2");
  static final Color quarternaryText = SharedFunction.hexToColor("000000").withOpacity(0.2);

  // Fills
  static final Color primaryFill = SharedFunction.hexToColor("000000").withOpacity(0.45);
  static final Color secondaryFill = SharedFunction.hexToColor("000000").withOpacity(0.2);
  static final Color tertiaryFill = SharedFunction.hexToColor("000000").withOpacity(0.1);

  // Slider Dots
  static final Color unselectedDot = SharedFunction.hexToColor("0A0A0A").withOpacity(0.66);
  static final Color selectedDot = SharedFunction.hexToColor("F2D450");

  // BORDER RADIUS
  static BorderRadius borderRadius(double tl, double tr, double bl, double br){
    return BorderRadius.only(
            topLeft: Radius.circular(tl),
            topRight: Radius.circular(tr),
            bottomLeft: Radius.circular(bl),
            bottomRight: Radius.circular(bl)
          );
  }

 static final appBarTitle = TextStyle(
   color: SharedStyle.yellow,
 ); 

 static final productName = TextStyle(
   color: SharedStyle.primaryText,
   fontSize: 14,
   fontFamily: 'SFProText-Bold',
   fontWeight: FontWeight.bold
 );

 static final productPrice = TextStyle(
   color: SharedStyle.secondaryText,
   fontSize: 14,
   fontFamily: 'SFProText-Regular',
 );
  
  static final productPriceLineThrough = TextStyle(
    color: SharedStyle.secondaryText,
    fontSize: 14,
    fontFamily: 'SFProText-Regular',
    decoration: TextDecoration.lineThrough
  );

 static final sellerName = TextStyle(
   color: SharedStyle.primaryText,
   fontSize: 18,
   fontFamily: 'SFProText-Bold',
   fontWeight: FontWeight.bold
 );

 static final sellerRating = TextStyle(
   color: SharedStyle.yellow,
   fontSize: 16,
   fontFamily: 'SFProText-Bold',
   fontWeight: FontWeight.bold
 );

 static final sellerAddress = TextStyle(
   color: SharedStyle.secondaryText,
   fontSize: 14,
   fontFamily: 'SFProText-Regular',
 );

 static final title = TextStyle(
  color: SharedStyle.black,
  fontSize: 35,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Bold'
 );

 static final titleYellow = TextStyle(
  color: SharedStyle.yellow,
  fontSize: 35,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Bold'
 );

 static final subTitle = TextStyle(
  color: SharedStyle.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Bold'
 );

 static final subTitleYellow = TextStyle(
  color: SharedStyle.yellow,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Bold'
 );

  static final yellowBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.yellow),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
      )
    )
  );
  
  static final yellowBtnText = TextStyle(
    fontSize: 18,
    color: SharedStyle.white,
    fontFamily: 'Poppins-Regular'
  );

  static final labelBold = TextStyle(
    fontSize: 15,
    color: SharedStyle.primaryText,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins-Bold'
  );

  static final labelRegular = TextStyle(
    fontSize: 15,
    color: SharedStyle.primaryText,
    fontFamily: 'Poppins-Regular'
  );

  static final searchBarBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(10, 10, 10, 10)
      )
    )
  );



  // NEW STYLES
  static final Color red = SharedFunction.hexToColor("FC5C53");
  static final Color white = SharedFunction.hexToColor("FFFFFF");
  static final Color grey = SharedFunction.hexToColor("7F7F7F");
  static final Color black = SharedFunction.hexToColor("000000");

  static final Color backgroundRed = SharedStyle.red;
  static final Color backgroundWhite = SharedStyle.white;

  static final Color blackText = SharedStyle.black;
  static final Color greyText = SharedStyle.grey;
  static final Color whiteText = SharedStyle.white;

  static final double btnWidth = 300;
  static final double btnHeight = 60;

  static final redBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.red),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(20, 20, 20, 20)
      )
    )
  );

  static final redBtnText = TextStyle(
    fontSize: 18,
    color: SharedStyle.white,
    fontFamily: 'Poppins-Regular'
  );

  static final whiteBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(20, 20, 20, 20)
      )
    )
  );

  static final whiteBtnText = TextStyle(
    fontSize: 18,
    color: SharedStyle.red,
    fontFamily: 'Poppins-Regular'
  );
  
  static final h1 = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 14,
    fontFamily: 'SFProText-Bold',
    fontWeight: FontWeight.bold
  );
}