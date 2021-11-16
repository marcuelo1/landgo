import 'package:flutter/material.dart';
import 'package:landgo_seller/core/functions/style_function.dart';
import 'package:landgo_seller/shared/shared_style.dart';

class ButtonWidgets {
  static Widget redBtn({required void Function()onPressed, String name = "", double width = 0, double height = 0}){
    return Container(
      decoration: SharedStyle.btnContainerDecor,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: SharedStyle.redBtn,
        child: Container(
          width: StyleFunction.scaleWidth(SharedStyle.btnWidth, width),
          height: StyleFunction.scaleHeight(SharedStyle.btnHeight, height),
          child: Center(
            child: Text(
              name,
              style: SharedStyle.redBtnText,
            ),
          ),
        )
      ),
    );
  }

  static Widget whiteBtn(Function()function, String name, double width, double height){
    return Container(
      decoration: SharedStyle.btnContainerDecor,
      child: ElevatedButton(
        onPressed: function, 
        style: SharedStyle.whiteBtn,
        child: Container(
          width: StyleFunction.scaleWidth(SharedStyle.btnWidth, width),
          height: StyleFunction.scaleHeight(SharedStyle.btnHeight, height),
          child: Center(
            child: Text(
              name,
              style: SharedStyle.whiteBtnText,
            ),
          ),
        )
      ),
    );
  }

}