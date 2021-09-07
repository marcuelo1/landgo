import 'package:flutter/material.dart';
import 'package:ryve_mobile/locations/list_of_locations_style.dart';
import 'package:ryve_mobile/shared/headers.dart';
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
  String _dataUrl ="${SharedUrl.root}/${SharedUrl.version}/buyer/carts/list_of_sellers";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double addressWidth = 347;
  final double addressHeight = 60;

  List addresses = [
    {
      "id": 1,
      "name": "Home",
      "details": "Bacolod City, Negros Occidental"
    },
    {
      "id": 2,
      "name": "Office",
      "details": "Bacolod City, Negros Occidental"
    }
  ];
  int selectedAddress = 0;

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

    return content(context);
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var _address in addresses) ... [
                  address(_address)
                ]
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget address(Map _address){
    return Container(
      width: SharedFunction.scaleWidth(addressWidth, width),
      height: SharedFunction.scaleHeight(addressHeight, height),
      decoration: selectedAddress == _address['id'] ? ListOfLocationsStyle.addressSelectedContainer : ListOfLocationsStyle.addressUnselectedContainer,
      child: Padding(
        padding: EdgeInsets.only(
          left: SharedFunction.scaleWidth(15, width),
          right: SharedFunction.scaleWidth(5, width),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // radio button
            // address details
            addressDetails(_address),
            // edit button
            addressEditBtn(_address)
          ],
        ),
      ),
    );
  }

  Widget addressDetails(Map _address){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = _address['id'];
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // address name with icon
          addressName(_address['name']),
          // address location
          addressLocation(_address['details'])
        ],
      ),
    );
  }

  Widget addressName(String _name){
    return Row(
      children: [
        // icon
        Icon(
          Icons.home,
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
    return Text(
      _location,
      style: ListOfLocationsStyle.addressLocation,
    );
  }

  Widget addressEditBtn(Map _address){
    return Center(
      child: IconButton(
        onPressed: (){
          print("object");
        },
        icon: Icon(
          Icons.edit
        ),
      ),
    );
  }
}