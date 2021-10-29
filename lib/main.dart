import 'package:flutter/material.dart';
import 'package:landgo_rider/home/home.dart';
import 'package:landgo_rider/profile/profile.dart';
import 'package:landgo_rider/shared/headers.dart';
import 'package:landgo_rider/sign_in/sign_in.dart';
import 'package:landgo_rider/splash/splash.dart';

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
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (context) => Splash(),
        SignIn.routeName: (context) => SignIn(),
        Home.routeName: (context) => Home(),
        Profile.routeName: (context) => Profile(),
      },
    );
  }
}
