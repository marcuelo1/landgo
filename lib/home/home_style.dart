import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class HomeStyle {
 static final title = TextStyle(
   color: SharedStyle.primaryText,
   fontSize: 35,
   fontFamily: 'Poppins-Bold',
   fontWeight: FontWeight.bold,
 );

 static final categoryName = TextStyle(
   color: SharedStyle.white,
   fontSize: 20,
   fontFamily: 'Poppins-Bold',
   fontWeight: FontWeight.bold,
 );

 static final yellowOverlay = BoxDecoration(
   color: SharedStyle.yellow,
   borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
 );

 static final blackOverlay = BoxDecoration(
   color: SharedStyle.black,
   borderRadius: SharedStyle.borderRadius(20, 20, 20, 20),
 );

 static final draggablePage = BoxDecoration(
   borderRadius: SharedStyle.borderRadius(20, 20, 0, 0),
   color: SharedStyle.white,
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
}