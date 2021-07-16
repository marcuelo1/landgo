import 'package:flutter/material.dart';
import 'shared_function.dart';

class SharedStyle {
  // Check ryve prototype colors first row (from left to right)
  static final Color lightyellow = SharedFunction.hexToColor("F7F052");
  static final Color yellow = SharedFunction.hexToColor("F2D450");
  static final Color darkyellow = SharedFunction.hexToColor("B79332");
  static final Color brown = SharedFunction.hexToColor("F7F052");
  static final Color darkbrown = SharedFunction.hexToColor("F7F052");

  // Shades of black, check ryve prototype colors (from left to right) 
  // Note: some of the colors are the same
  static final Color dirtyWhite = SharedFunction.hexToColor("3A3A3C");
  static final Color black = SharedFunction.hexToColor("000000");
  static final Color black2 = SharedFunction.hexToColor("1C1C1E");
  static final Color black3 = SharedFunction.hexToColor("2C2C2E");
  static final Color black4 = SharedFunction.hexToColor("3A3A3C");


  // BORDER RADIUS
  static BorderRadius borderRadius(double tl, double tr, double bl, double br){
    return BorderRadius.only(
            topLeft: Radius.circular(tl),
            topRight: Radius.circular(tr),
            bottomLeft: Radius.circular(bl),
            bottomRight: Radius.circular(bl)
          );
  }
  
}