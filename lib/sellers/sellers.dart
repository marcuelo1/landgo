import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class Sellers extends StatefulWidget {
  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    
    return PixelPerfect(
      child: SafeArea(
        child: Scaffold(
          body: Text("sellers"),
        )
      )
    );
  }
}