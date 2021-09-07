import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class ListOfLocationsStyle {
  static final addressName = TextStyle(
    color: SharedStyle.primaryText,
    fontSize: 16,
    fontFamily: 'Poppins-Bold',
    fontWeight: FontWeight.bold
  );

  static final addressLocation = TextStyle(
    color: SharedStyle.secondaryText,
    fontSize: 12,
    fontFamily: 'Poppins-Regular'
  );

  static final addressSelectedContainer = BoxDecoration(
    color: SharedStyle.lightyellow,
    borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
  );

  static final addressUnselectedContainer = BoxDecoration(
    borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
  );
}