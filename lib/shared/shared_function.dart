import 'package:flutter/material.dart';

class SharedFunction {
  static Color hexToColor(String code){
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static double widthPercent(BuildContext context, double percent){
    percent = percent / 100.0;
    return MediaQuery.of(context).size.width * percent;
  }

  static double heightPercent(BuildContext context, double percent){
    percent = percent / 100.0;
    return MediaQuery.of(context).size.height * percent;
  }
}