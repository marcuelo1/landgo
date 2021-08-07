import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class SignUpStyle {
  static final title = TextStyle(
                        fontSize: 35,
                        color: SharedStyle.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold'
                      );
  
  static final signUpBtn = BoxDecoration(
                            color: SharedStyle.yellow,
                            borderRadius: SharedStyle.borderRadius(30, 30, 30, 30)
                          );

  static final signUpText = TextStyle(
                              fontSize: 18,
                              color: SharedStyle.white,
                              fontFamily: 'Poppins-Regular'
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
}