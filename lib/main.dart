import 'package:flutter/material.dart';
import 'package:ryve_mobile/home/home.dart';
import 'package:ryve_mobile/sign_up/sign_up.dart';
import 'welcome_page/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'signup',
      routes: {
        '/': (context) => WelcomePage(),
        'signup': (context) => SignUp(),
        'home': (context) => Home()
      },
    );
  }
}
