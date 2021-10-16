import 'package:flutter/material.dart';
import 'package:ryve_mobile/cart/cart.dart';
import 'package:ryve_mobile/cart/review_payment_location.dart';
import 'package:ryve_mobile/home/home.dart';
import 'package:ryve_mobile/home/search_page.dart';
import 'package:ryve_mobile/home/search_results.dart';
import 'package:ryve_mobile/locations/location_form.dart';
import 'package:ryve_mobile/locations/list_of_locations.dart';
import 'package:ryve_mobile/sellers/show_seller.dart';
import 'package:ryve_mobile/sellers/product.dart';
import 'package:ryve_mobile/sellers/sellers.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/sidebar/list_of_transactions.dart';
import 'package:ryve_mobile/sidebar/list_of_vouchers.dart';
import 'package:ryve_mobile/sidebar/profile.dart';
import 'package:ryve_mobile/sign_in/sign_in.dart';
import 'package:ryve_mobile/sign_up/sign_up.dart';
import 'package:ryve_mobile/splash/splash.dart';
import 'package:ryve_mobile/transactions/current_transaction_show.dart';
import 'package:ryve_mobile/transactions/current_transactions.dart';
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
      initialRoute: 'splash',
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (context) => Splash(),
        WelcomePage.routeName: (context) => WelcomePage(),
        SignUp.routeName: (context) => SignUp(),
        SignIn.routeName: (context) => SignIn(),
        Home.routeName: (context) => Home(),
        Sellers.routeName: (context) => Sellers(),
        ShowSeller.routeName: (context) => ShowSeller(),
        Product.routeName: (context) => Product(),
        Cart.routeName: (context) => Cart(),
        ListOfLocations.routeName: (context) => ListOfLocations(),
        LocationForm.routeName: (context) => LocationForm(),
        Profile.routeName: (context) => Profile(),
        ReviewPaymentLocation.routeName: (context) => ReviewPaymentLocation(),
        ListOfTransactions.routeName: (context) => ListOfTransactions(),
        CurrentTransactions.routeName: (context) => CurrentTransactions(),
        CurrentTransactionShow.routeName: (context) => CurrentTransactionShow(),
        ListOfVouchers.routeName: (context) => ListOfVouchers(),
        SearchPage.routeName: (context) => SearchPage(),
        SearchResults.routeName: (context) => SearchResults(),
      },
    );
  }
}