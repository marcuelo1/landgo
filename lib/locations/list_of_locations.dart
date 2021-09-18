import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ryve_mobile/locations/location_form.dart';
import 'package:ryve_mobile/locations/list_of_locations_style.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/loading.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class ListOfLocations extends StatefulWidget {
  static const String routeName = "list_of_locations";

  @override
  _ListOfLocationsState createState() => _ListOfLocationsState();
}

class _ListOfLocationsState extends State<ListOfLocations> {
  // url
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/locations";
  String _selectAddressUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/locations";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double addressDetailWidth = 200;
  final double addressWidth = 347;
  final double addressHeight = 60;
  final double addBtnWidth = 150;
  final double addBtnHeight = 30;

  // response
  Map response = {};
  Map responseBody = {};
  bool refresh = true;

  List locations = [];
  int selectedAddress = 0;
  Map currentLocation = {};

  // headers
  Map<String, String> _headers = {};
  @override
  void initState() {
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    return !refresh ? content(context) : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("check internet");
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            // get response
            response = snapshot.data;
            responseBody = response['body'];
            print(responseBody);
            print("==============================================================");

            if (responseBody["locations"].length > 0) {
              locations = json.decode(responseBody["locations"]);
            }

            selectedAddress = responseBody["selected_location"];
            currentLocation = json.decode(responseBody["current_location"]);

            return content(context);
        }
      }
    );
  }

  Widget content(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, "Addresses"),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(10, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(10, width),
            SharedFunction.scaleHeight(0, height)
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addAddress(),
                for (var _location in locations) ... [
                  address(_location)
                ]
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget address(Map _location){
    return Container(
      width: SharedFunction.scaleWidth(addressWidth, width),
      height: SharedFunction.scaleHeight(addressHeight, height),
      decoration: selectedAddress == _location['id'] ? ListOfLocationsStyle.addressSelectedContainer : ListOfLocationsStyle.addressUnselectedContainer,
      child: Padding(
        padding: EdgeInsets.only(
          left: SharedFunction.scaleWidth(15, width),
          right: SharedFunction.scaleWidth(5, width),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // address details
            addressDetails(_location),
            // edit button
            if (_location['name'] != "Current Location") ... [
              addressEditBtn(_location)
            ]
          ],
        ),
      ),
    );
  }

  Widget addressDetails(Map _location){
    bool isCurrent = _location['name'] == "Current Location" ? true : false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = _location['id'];
          refresh = false;
        });
        String _rawUrl = _selectAddressUrl + "/select_location?id=$selectedAddress";
        var _response = SharedFunction.sendData(_rawUrl, _headers, {});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // address name with icon
          addressName(_location['name'], isCurrent),
          // address location
          addressLocation(_location['description'])
        ],
      ),
    );
  }

  Widget addressName(String _name, bool isCurrent){
    return Row(
      children: [
        // icon
        Icon(
          isCurrent ? Icons.location_on : Icons.home,
        ),
        // space
        SizedBox(width: SharedFunction.scaleWidth(10, width),),
        // name
        Text(
          _name,
          style: ListOfLocationsStyle.addressName,
        )
      ],
    );
  }

  Widget addressLocation(String _location){
    return Container(
      width: SharedFunction.scaleWidth(addressDetailWidth, width),
      child: Text(
        _location,
        style: ListOfLocationsStyle.addressLocation,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget addressEditBtn(Map _location){
    return Center(
      child: IconButton(
        onPressed: () async {
          print(_location['id']);
          await Navigator.pushNamed(context, LocationForm.routeName, arguments: {"location": _location});
          setState(() => refresh = true);
        },
        icon: Icon(
          Icons.edit
        ),
      ),
    );
  }

  Widget addAddress(){
    return Container(
      width: SharedFunction.scaleWidth(addBtnWidth, width),
      height: SharedFunction.scaleHeight(addBtnHeight, height),
      child: ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, LocationForm.routeName, arguments: {"location": currentLocation});
          setState(() => refresh = true);
        }, 
        style: SharedStyle.yellowBtn,
        child: Center(
          child: Text(
            "Add Address",
            style: SharedStyle.yellowBtnText,
          ),
        )
      ),
    );
  }
}