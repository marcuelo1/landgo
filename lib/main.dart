import 'package:flutter/material.dart';
import 'package:ryve_mobile/home/home.dart';
import 'package:ryve_mobile/sellers/sellers.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/sign_in/sign_in.dart';
import 'package:ryve_mobile/sign_up/sign_up.dart';
import 'welcome_page/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Headers.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        WelcomePage.routeName: (context) => WelcomePage(),
        SignUp.routeName: (context) => SignUp(),
        SignIn.routeName: (context) => SignIn(),
        Home.routeName: (context) => Home(),
        Sellers.routeName: (context) => Sellers(),
      },
    );
  }
}
