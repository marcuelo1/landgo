import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class ProductStyle {
  static final productName = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 35,
    fontFamily: 'Poppins-Bold',
    fontWeight: FontWeight.bold,
  );

  static final productDescription = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 18,
    fontFamily: 'Poppins-Regular',
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

  static final selectedSubTitleLineThrough = TextStyle(
    color: SharedStyle.white,
    fontSize: 15,
    fontFamily: 'SFProText-Regular',
    decoration: TextDecoration.lineThrough
  );

  static final unselectedSubTitleLineThrough = TextStyle(
    color: SharedStyle.black,
    fontSize: 15,
    fontFamily: 'SFProText-Regular',
    decoration: TextDecoration.lineThrough
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
    backgroundColor: MaterialStateProperty.all(SharedStyle.red),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
      )
    )
  );

  static final quantityBar = BoxDecoration(
    borderRadius: SharedStyle.borderRadius(30, 30, 30, 30),
    border: Border.all(color: SharedStyle.red)
  );

  static final quantityBarNum = TextStyle(
    color: SharedStyle.red,
    fontSize: 20,
    fontFamily: 'SFProText-Bold',
    fontWeight: FontWeight.bold,
  );

  static final totalAmount = TextStyle(
    color: SharedStyle.red,
    fontSize: 20,
    fontFamily: 'SFProText-Bold',
    fontWeight: FontWeight.bold,
  );
}