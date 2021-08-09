import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map _headers = {};

  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }
  @override
  Widget build(BuildContext context) {
    return PixelPerfect(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0), // temporary
          child: Scaffold(
            appBar: AppBar(title: Text("asd"), backgroundColor: SharedStyle.yellow,),
            drawer: Drawer(
              child: sideBar(),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: SharedStyle.yellow),
            ),
          ),
        )
      )
    );
  }

  Widget sideBar(){
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}