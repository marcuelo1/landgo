import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/shared_style.dart';

class SignInStyle {
  static final title = TextStyle(
                        fontSize: 35,
                        color: SharedStyle.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'
                      );

  static final regularText = TextStyle(
                              fontSize: 16,
                              color: SharedStyle.black,
                              fontFamily: 'Poppins-Regular'
                            );

  static final yellowText = TextStyle(
                              fontSize: 16,
                              color: SharedStyle.yellow,
                              fontFamily: 'Poppins-Regular'
                            );

  static final signInText = TextStyle(
                              fontSize: 18,
                              color: SharedStyle.white,
                              fontFamily: 'Poppins-Regular'
                            );
  
  static final signInBtn = ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(SharedStyle.yellow),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
                              )
                            )
                          );
}