import 'package:flutter/material.dart';
import 'package:ryve_mobile/shared/shared_style.dart';

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
  static Future <void> error (BuildContext context) async {
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: SharedStyle.yellow,
        content: Column(
          children: [
            // content
            _errorContent(),
            // close button
            _errorBtn(context)
          ],
        ),
      )
    );
  }

  static Widget _errorContent () {
    return Text("Error");
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