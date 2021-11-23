import 'package:flutter/material.dart';
import 'package:landgo_seller/core/data/shared_preferences_data.dart';
import 'package:landgo_seller/features/operations/controllers/list_of_products_controller.dart';
import 'package:landgo_seller/features/operations/controllers/product_form_controller.dart';
import 'package:landgo_seller/features/operations/views/list_of_products_view.dart';
import 'package:landgo_seller/features/operations/views/operations_view.dart';
import 'package:landgo_seller/features/operations/views/product_form_view.dart';
import 'package:landgo_seller/features/pending_transactions/controllers/pending_transactions_controller.dart';
import 'package:landgo_seller/features/pending_transactions/views/pending_transactions.dart';
import 'package:landgo_seller/features/profile/controllers/profile_controller.dart';
import 'package:landgo_seller/features/profile/views/profile.dart';
import 'package:landgo_seller/features/sign_in/views/sign_in.dart';
import 'package:landgo_seller/features/splash/views/splash.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesData.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PendingTransactionsController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => ListOfProductsController()),
        ChangeNotifierProvider(create: (_) => ProductFormController())
      ],
      child: const MyApp(),
    )
  );
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
        Profile.routeName: (context) => Profile(),
        OperationsView.routeName: (context) => OperationsView(),
        ListOfProductsView.routeName: (context) => ListOfProductsView(),
        ProductFormView.routeName: (context) => ProductFormView()
      },
    );
  }
}
