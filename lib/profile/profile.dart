import 'package:flutter/material.dart';
import 'package:landgo_rider/shared/error_page.dart';
import 'package:landgo_rider/shared/headers.dart';
import 'package:landgo_rider/shared/loading.dart';
import 'package:landgo_rider/shared/shared_function.dart';
import 'package:landgo_rider/shared/shared_style.dart';
import 'package:landgo_rider/shared/shared_url.dart';
import 'package:landgo_rider/shared/shared_widgets.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/rider/profile";
  String _changeShiftUrl = "${SharedUrl.root}/${SharedUrl.version}/rider/change_shift";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;
  
  // variables
  bool refresh = true;
  Map rider = {};
  Map statuses = {0: "Not Logged In", 1: "On Shift", 2: "Off Shift", 3: "On Break", 4: "On Deliver"};

  // headers
  Map<String,String> _headers = {};
  @override
  void initState(){
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  Widget build(BuildContext context) {
    return !refresh ? _buildContent(context) : FutureBuilder(
      future: SharedFunction.getData(_dataUrl, _headers),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // Connection state of getting the data
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ErrorPage();
          case ConnectionState.waiting: // Retrieving
            return Loading();
          default: // Success of connecting to back end
            // check if snapshot has an error
            if (snapshot.hasError) {
              return  ErrorPage();
            }
            refresh = false;

            // get response
            var response = snapshot.data;
            var responseBody = response['body'];
            print(responseBody);
            print("============================================================== response body");
            
            rider = responseBody['rider'];

            return _buildContent(context);
        }
      }
    );
  }

  Widget _buildContent(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context),
        bottomNavigationBar: SharedWidgets.bottomAppBar(context),
        drawer: SharedWidgets.sideBar(context, rider, _headers),
        backgroundColor: SharedStyle.yellow,
        body: Center(
          child: Column(
            children: [
              // details
              _buildDetails(),
              // start or end shift
              _buildShiftBtn(),
              // request a break
            ],
          ),
        ),
      )
    );
  }

  Widget _buildDetails(){
    return Container(
      color: SharedStyle.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first name
          _buildContentLabel("First Name"),
          _buildContentValue(rider['first_name']),
          // last name
          _buildContentLabel("Last Name"),
          _buildContentValue(rider['last_name']),
          // email
          _buildContentLabel("Email"),
          _buildContentValue(rider['email']),
          // phone number
          _buildContentLabel("Phone Number"),
          _buildContentValue(rider['phone_number']),
          // status
          _buildContentLabel("Status"),
          _buildContentValue(statuses[rider['status']]),
        ],
      ),
    );
  }
  
  Widget _buildContentLabel(String _label){
    return Text(
      _label,
      style: SharedStyle.labelBold
    );
  }

  Widget _buildContentValue(String _value){
    return Text(
      _value,
      style: SharedStyle.labelRegular
    );
  }

  Widget _buildShiftBtn(){
    return ElevatedButton(
      onPressed: ()async{
        switch (rider['status']) {
          case 1: // status is On Shift, needs to end the shift
            Map _data = {
              "status": 2
            };
            Map _response = await SharedFunction.sendData(_changeShiftUrl, _headers, _data, 'put');

            if(_response['status'] == 200){
              setState(() {
                rider['status'] = 2;
              });
            }

            break;
          case 2: // status is Off Shift, needs to start the shift
            Map _data = {
              "status": 1
            };
            Map _response = await SharedFunction.sendData(_changeShiftUrl, _headers, _data, 'put');

            if(_response['status'] == 200){
              setState(() {
                rider['status'] = 1;
              });
            }
            break;
          case 3: // status is On Break, needs to finish the break before ending the shift
            
            break;
          case 4: // status is On Deliver, needs to finish the delivery before ending the shift
            
            break;
        }
      }, 
      child: Text(
        rider['status'] == 2 ? "Press To Start Shift" : "Press To End Shift"
      )
    );
  }
}