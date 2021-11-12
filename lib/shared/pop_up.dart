import 'package:flutter/material.dart';
import 'package:landgo_seller/shared/shared_style.dart';

class PopUp {
  ///////////////////////////
  /// SUCCESSFUL SECTION ///
  ///////////////////////////
  static Future <void> successful(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
            backgroundColor: SharedStyle.yellow,
            content: Column(
              children: [
                // content
                _successfulContent(),
                // close button
                _successfulBtn(context)
              ],
            ),
        )
    );
  }

  static Widget _successfulContent () {
    return Text("Success");
  }

  static Widget _successfulBtn (BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: Text("Close"),
    );
  }
  /////////////////////////// END OF SUCCESSFUL SECTION ///////////////////////////
  
  ///////////////////////////
  ////// ERROR SECTION //////
  ///////////////////////////
  static Future <void> error (BuildContext context, [String message = "Oops there is an error in server"]) async {
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: SharedStyle.yellow,
        content: Container(
          height: 300,
          child: Column(
            children: [
              // content
              _errorContent(message),
              // close button
              _errorBtn(context)
            ],
          ),
        ),
      )
    );
  }

  static Widget _errorContent (String message) {
    return Text(message);
  }

  static Widget _errorBtn (BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: Text("Close"),
    );
  }
  /////////////////////////// END OF ERROR SECTION ///////////////////////////
}