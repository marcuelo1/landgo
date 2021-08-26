import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class ProductStyle {
  static final productName = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 35,
   fontFamily: 'Poppins-Bold',
   fontWeight: FontWeight.bold,
  );
  
  static final productPrice = TextStyle(
    color: SharedStyle.secondaryText,
    fontSize: 20,
    fontFamily: 'SFProText-Regular',
  );

  static final title = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 20,
    fontFamily: 'SFProText-Bold',
    fontWeight: FontWeight.bold,
  );

  static final require = TextStyle(
    color: SharedStyle.yellow,
    fontSize: 15,
    fontFamily: 'SFProText-Regular',
  );

  static final requireContainer = BoxDecoration(
    borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
    color: SharedStyle.black4
  );

  static final selectedSubTitle = TextStyle(
    color: SharedStyle.white,
    fontSize: 15,
    fontFamily: 'SFProText-Regular',
  );

  static final unselectedSubTitle = TextStyle(
    color: SharedStyle.black,
    fontSize: 15,
    fontFamily: 'SFProText-Regular',
  );
  
  static final unselectedBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
      )
    )
  );
  
  static final selectedBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(SharedStyle.yellow),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
      )
    )
  );
}