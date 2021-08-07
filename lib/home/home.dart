import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PixelPerfect(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0), // temporary
          child: Scaffold(
            body: Text("Home page"),
          ),
        )
      )
    );
  }
}