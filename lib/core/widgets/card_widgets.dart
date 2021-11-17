import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/core/styles/shared_style.dart';

class CardWidgets {
  static Widget card({required double cardWidth, required double referenceWidth, required Widget child}){
    return Container(
      width: StyleFunction.scaleWidth(cardWidth, referenceWidth),
      decoration: BoxDecoration(
        borderRadius: SharedStyle.borderRadius(10, 10, 10, 10),
        color: SharedStyle.white,
      ),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}