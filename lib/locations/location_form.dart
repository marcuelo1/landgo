import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryve_mobile/shared/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/shared/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/shared/shared_widgets.dart';

class LocationForm extends StatefulWidget {
  static const String routeName = "add_location";

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  // url
  String _dataUrlAddLoc = "${SharedUrl.root}/${SharedUrl.version}/buyer/locations";

  // dimensions
  final double addBtnWidth = 347;
  final double addBtnHeight = 60;
  final double locationDetailsWidth = 375;
  final double locationDetailsHeightPercent = .4;
  final double mapHeightPercent = .5;

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // controller
  late GoogleMapController _googleMapController;

  // form key
  final formKey = GlobalKey<FormState>();
  // variables
  var pinMarker;
  var coordinates;
  var _details;
  var _name;
  var location;
  var _initialCameraPosition;

  // headers
  Map<String, String> _headers = {};
  @override
  void initState() {
    super.initState();
    _headers = Headers.getHeaders();
    print(_headers);
  }

  @override
  void dispose(){
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    scale = SharedStyle.referenceWidth / width;

    // arguments
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    // ignore: unnecessary_null_comparison
    location = args['location'];
    _initialCameraPosition = CameraPosition(
      target: LatLng(location['latitude'], location['longitude']),
      zoom: 18
    );


    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, title: "Pin Location"),
        body: Column(
          children: [
            mapContent(),
            locationDetails()
          ],
        ),
      )
    );
  }

  Widget mapContent(){
    double mapHeight = (SharedStyle.referenceHeight - AppBar().preferredSize.height) * mapHeightPercent;
    
    return Container(
      height: SharedFunction.scaleHeight(mapHeight, height),
      child: Stack(
        children: [
          gMap(),
          pinIcon(),
        ],
      ),
    );
  }

  Widget locationDetails(){
    double locationDetailsHeight = (SharedStyle.referenceHeight - AppBar().preferredSize.height) * locationDetailsHeightPercent;

    return Container(
      width: SharedFunction.scaleWidth(locationDetailsWidth, width),
      height: SharedFunction.scaleHeight(locationDetailsHeight, height),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height),
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(30, height)
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              nameInput(),
              SizedBox(height: SharedFunction.scaleHeight(10, height),),
              detailsInput(),
              SizedBox(height: SharedFunction.scaleHeight(50, height),),
              addBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget gMap(){
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {
        if (pinMarker != null) pinMarker
      },
      onCameraMove: storeCoordinates,
      // onCameraIdle: setMarker,
    );
  }

  Widget pinIcon(){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: SharedFunction.scaleHeight(35, height)),
        child: Icon(
          Icons.location_on,
          size: 40,
          color: SharedStyle.black,
        ),
      ),
    );
  }

  void storeCoordinates(CameraPosition camPos){
    coordinates = camPos.target;
    print(coordinates);
  }

  void setMarker(){
    if (coordinates != null){
      setState(() {
        pinMarker = Marker(
          markerId: const MarkerId("pin"),
          infoWindow: const InfoWindow(title: "Pin"),
          position: coordinates
        );
      });
    }
  }
  
  Widget addBtn(){
    return Container(
      width: SharedFunction.scaleWidth(addBtnWidth, width),
      height: SharedFunction.scaleHeight(addBtnHeight, height),
      child: ElevatedButton(
        onPressed: () async {
          print(coordinates);
          if(!formKey.currentState!.validate()){
            return;
          }

          // Save form inputs to their variables
          formKey.currentState!.save();

          // Send data to backend
          Map _data = {
            "latitude": coordinates.latitude,
            "longitude": coordinates.longitude,
            "name": _name,
            "details": _details,
          };
          
          late String _rawUrl;
          var _response;

          if(location['name'] != "Current Location"){
            _rawUrl = _dataUrlAddLoc +  "/${location['id']}";

            _response = await SharedFunction.sendData(_rawUrl, _headers, _data, "put");
          }else{
            _rawUrl = _dataUrlAddLoc;

            _response = await SharedFunction.sendData(_rawUrl, _headers, _data);
          }
          print(_response);

          if(_response['status'] == 200){
            Navigator.pop(context);
          }
        },
        style: SharedStyle.yellowBtn,
        child: Center(
          child: Text(
            "Save Location",
            style: SharedStyle.yellowBtnText,
          ),
        ),
      ),
    );
  }

  Widget nameInput(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Name"),
      initialValue: location['name'] != "Current Location" ? location['name'] : "",
      validator: (value) {
        if(value!.isEmpty){
          return "Name is required";
        }
      },
      onSaved: (value) => _name = value,
    );
  }

  Widget detailsInput(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Floor/Unit/Room #"),
      initialValue: location['details'] != null ? location['details'] : "",
      onSaved: (value) => _details = value,
    );
  }
}