import 'package:flutter/material.dart';
import 'package:ryve_mobile/core/entities/headers.dart';
import 'package:ryve_mobile/shared/shared_function.dart';
import 'package:ryve_mobile/core/styles/shared_style.dart';
import 'package:ryve_mobile/shared/shared_url.dart';
import 'package:ryve_mobile/core/widgets/shared_widgets.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // url
  String _dataUrl = "${SharedUrl.root}/${SharedUrl.version}/buyer";

  // variables for scale functions
  late double width;
  late double height;
  late double scale;

  // dimensions
  final double cardWidth = 200;

  Map _buyer = {};
  bool editName = false;
  bool editEmail = false;
  bool editMobile = false;
  String firstName = "";
  String lastName = "";
  String email = "";
  String mobileNumber = "";

  // form key
  final formNameKey = GlobalKey<FormState>();
  final formEmailKey = GlobalKey<FormState>();
  final formMobileKey = GlobalKey<FormState>();

  // headers 
  Map<String,String> _headers = {};
  Map response = {};

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

    _buyer = ModalRoute.of(context)!.settings.arguments as Map;

    print(_buyer);
    return SafeArea(
      child: Scaffold(
        appBar: SharedWidgets.appBar(context, title: "Profile"),
        backgroundColor: SharedStyle.yellow,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(20, height),
            SharedFunction.scaleWidth(24, width),
            SharedFunction.scaleHeight(0, height)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameContent(_buyer),
              SizedBox(height: SharedFunction.scaleHeight(30, height),),
              emailContent(_buyer),
              SizedBox(height: SharedFunction.scaleHeight(30, height),),
              mobileContent(_buyer)
            ],
          ),
        )
      )
    );
  }

  Widget nameContent(Map _buyer){
    return Container(
      width: SharedFunction.scaleHeight(cardWidth, height),
      color: SharedStyle.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height),
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height)
        ),
        child: Form(
          key: formNameKey,
          child: Column(
            children: [
              editBtn("name"),
              if (editName) ... [
                inputField("First Name", _buyer['first_name'], "First Name is required!", "firstName"),
                SizedBox(height: SharedFunction.scaleHeight(10, height),),
                inputField("Last Name", _buyer['last_name'], "Last Name is required!", "lastName"),
                SizedBox(height: SharedFunction.scaleHeight(20, height),),
                saveBtn("name")
              ] else ... [
                textName(_buyer['first_name']),
                SizedBox(height: SharedFunction.scaleHeight(10, height),),
                textName(_buyer['last_name']),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget emailContent(Map _buyer){
    return Container(
      width: SharedFunction.scaleHeight(cardWidth, height),
      color: SharedStyle.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height),
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height)
        ),
        child: Form(
          key: formEmailKey,
          child: Column(
            children: [
              editBtn("email"),
              if (editEmail) ... [
                inputField("Email", _buyer['email'], "Email is required!", "email"),
                SizedBox(height: SharedFunction.scaleHeight(20, height),),
                saveBtn("email")
              ] else ... [
                textName(_buyer['email']),
              ]
            ],
          ),
        ),
      ),
    );
  }
  
  Widget mobileContent(Map _buyer){
    return Container(
      width: SharedFunction.scaleHeight(cardWidth, height),
      color: SharedStyle.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height),
          SharedFunction.scaleWidth(10, width),
          SharedFunction.scaleHeight(10, height)
        ),
        child: Form(
          key: formMobileKey,
          child: Column(
            children: [
              editBtn("mobile"),
              if (editMobile) ... [
                inputField("Mobile Number", _buyer['phone_number'], "Mobile Number is required!", "mobileNumber"),
                SizedBox(height: SharedFunction.scaleHeight(20, height),),
                saveBtn("mobile")
              ] else ... [
                textName(_buyer['phone_number']),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget textName(String _name){
    return Text(_name);
  }

  Widget editBtn(String _editName){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              switch (_editName) {
                case "name":
                  editName = true;
                  break;
                case "email":
                  editEmail = true;
                  break;
                case "mobile":
                  editMobile = true;
                  break;
              }
            });
          }, 
          icon: Icon(Icons.edit)
        )
      ],
    );
  }

  Widget inputField(String label, String initialVal, String errorLabel, String varName){
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: initialVal,
      validator: (value){
        // check if input field is empty
        if(value!.isEmpty){
          return errorLabel;
        }
      },
      onSaved: (value) {
        switch (varName) {
          case "firstName":
            firstName = value!;
            break;
          case "lastName":
            lastName = value!;
            break;
          case "email":
            email = value!;
            break;
          case "mobileNumber":
            mobileNumber = value!;
            break;
        }
      },
    );
  }

  Widget saveBtn(String _editName){
    return ElevatedButton(
      onPressed: () async {
        String rawUrl = _dataUrl + "/${_buyer['id']}";
        switch (_editName) {
          case "name":
            if(!formNameKey.currentState!.validate()){
              return;
            }
            
            // Save form inputs to their variables
            formNameKey.currentState!.save();

            Map _data = {
              "first_name": firstName,
              "last_name": lastName,
              "update_type": "name"
            };

            var _response = await SharedFunction.sendData(rawUrl, _headers, _data, "put");

            if (_response['status'] == 200) {
              setState(() {
                editName = false;
                _buyer['first_name'] = firstName;
                _buyer['last_name'] = lastName;
              });
            }
            break;
          case "email":
            if(!formEmailKey.currentState!.validate()){
              return;
            }
            
            // Save form inputs to their variables
            formEmailKey.currentState!.save();

            Map _data = {
              "email": email,
              "update_type": "email"
            };

            var _response = await SharedFunction.sendData(rawUrl, _headers, _data, "put");

            if (_response['status'] == 200) {
              setState(() {
                editEmail = false;
                _buyer['email'] = email;
              });
            }
            break;
          case "mobile":
            if(!formMobileKey.currentState!.validate()){
              return;
            }
            
            // Save form inputs to their variables
            formMobileKey.currentState!.save();

            Map _data = {
              "mobile": mobileNumber,
              "update_type": "mobile"
            };

            var _response = await SharedFunction.sendData(rawUrl, _headers, _data, "put");

            if (_response['status'] == 200) {
              setState(() {
                editMobile = false;
                _buyer['phone_number'] = mobileNumber;
              });
            }
            break;
        }
      }, 
      style: SharedStyle.yellowBtn,
      child: Center(
        child: Text(
          "Save",
          style: SharedStyle.yellowBtnText,
        ),
      )
    );
  }
}