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
  static final Color white = SharedFunction.hexToColor("FFFFFF");
  static final Color white2 = SharedFunction.hexToColor("#EFEFF4");
  static final Color black = SharedFunction.hexToColor("000000");
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
  
}