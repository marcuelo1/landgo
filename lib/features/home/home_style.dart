import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';

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
   border: Border.all(color: SharedStyle.grey),
   color: SharedStyle.white,
 );
}