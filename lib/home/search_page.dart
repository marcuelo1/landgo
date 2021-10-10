import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "search_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // Dimensions
  final double searchWidth = 40;
  
  // Headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return content(context);
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // search bar
            searchBarContainer(),
            // suggestions
          ],
        ),
      )
    );
  }

  Widget searchBarContainer(){
    return Row(
      children: [
        // back button
        backBtn(),
        // search bar
        searchBar(),
        // clear button
      ],
    );
  }

  Widget backBtn(){
    return IconButton(
      onPressed: (){
        Navigator.pop(context);
      }, 
      icon: Icon(
        Icons.arrow_back
      )
    );
  }

  Widget searchBar(){
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          fillColor: SharedStyle.white,
          filled: true,
          hintText: "Search any product"
        ),
        autofocus: true,
        onChanged: searchFunction,
      ),
    );
  }

  void searchFunction(String keyword){
    
  }
}