import 'package:flutter/material.dart';
import 'package:landgo_seller/core/entities/headers.dart';
import 'package:landgo_seller/features/sign_in/views/sign_in.dart';
import 'package:landgo_seller/pending_transactions/pending_transactions.dart';
import 'package:landgo_seller/splash/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Headers.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (context) => Splash(),
        SignIn.routeName: (context) => SignIn(),
        PendingTransactions.routeName: (context) => PendingTransactions(),
      },
    );
  }
}
