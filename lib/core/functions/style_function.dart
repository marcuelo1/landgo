import 'package:flutter/material.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';

class StyleFunction {
  static Color hexToColor(String code){
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
  
  static double scaleWidth(double num, double width){
    return (num / SharedStyle.referenceWidth) * width;
  }
  
  static double scaleHeight(double num, double height){
    return (num / SharedStyle.referenceHeight) * height;
  }

  static double textScale(double width){
    if(width > SharedStyle.referenceWidth){
      return SharedStyle.referenceWidth / width;
    }else{
      return width / SharedStyle.referenceWidth;
    }
  }
  
}