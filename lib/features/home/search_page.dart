import 'package:flutter/material.dart';
import 'package:ryve_mobile/home/search_results.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "search_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer/search/suggestion_words";
  
  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // variables
  List suggestedWords = [];

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
            searchSuggestion()
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

  Widget searchSuggestion(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var _suggested in suggestedWords) ... [
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, SearchResults.routeName, arguments: {"keyword": _suggested});
            }, 
            child: Text(_suggested)
          ),
          SizedBox(height: SharedFunction.scaleHeight(10, height),)
        ]
      ],
    );
  }

  Future<void> searchFunction(String keyword) async {
    String _rawUrl = _dataUrl + "?keyword=$keyword";
    Map _response = await SharedFunction.getData(_rawUrl, _headers);

    if(_response['status'] == 200){
      Map _responseBody = _response['body'];
      setState(() {
        suggestedWords = _responseBody['suggested_words'];
      });
    }
  }
}