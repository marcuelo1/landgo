import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'shared_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SharedFunction {
  static Color hexToColor(String code){
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
  
  static double scaleWidth(double num, double width){
    return (num / SharedStyle.referenceWidth) * width;
  }
  
  static double scaleHeight(double num, double height){
    return (num / SharedStyle.referenceHeight) * height;
  }

  static double textScale(double width){
    if(width > SharedStyle.referenceWidth){
      return SharedStyle.referenceWidth / width;
    }else{
      return width / SharedStyle.referenceWidth;
    }
  }
  
  static Future<Map> getDataWithLoc(String rawUrl, Map<String,String> headers, [body]) async {
    // location
    var _latitude;
    var _longitude;
    bool _isCurrent;

    LatLng currentCoordinates = await getCurrentCoordinates();
    _latitude = currentCoordinates.latitude;
    _longitude = currentCoordinates.longitude;
    _isCurrent = true;

    rawUrl += "?latitude=$_latitude&longitude=$_longitude&is_current=$_isCurrent";

    if(body != null){
      body.forEach((key, value) {
        rawUrl += "&$key=$value";
      });
    }
    
    try {
      var url = Uri.parse(rawUrl);
      var data = await http.get(url, headers: headers);

      return {"status": data.statusCode, "body": json.decode(data.body)};
    } catch (e) {
      return {"status": 500};
    }
  }
  
  static Future<Map> getData(String rawUrl, Map headers) async {
    try {
      var url = Uri.parse(rawUrl);
      var data = await http.get(url, headers: headers as Map<String, String>);

      return {"status": data.statusCode, "body": json.decode(data.body)};
    } catch (e) {
      return {"status": 500};
    }
  }
  
  static Future<Map> sendData(String rawUrl, Map<String,String> headers, Map rawBody, [String method = "post"]) async {
    try {
      var url = Uri.parse(rawUrl);
      var data;
      var body = json.encode(rawBody);
      headers["Content-Type"] = "application/json";
      switch (method) {
        case "put":
          data = await http.put(url, headers: headers, body: body);
          break;
        case "delete":
          data = await http.delete(url, headers: headers, body: body);
          break;
        default:
          data = await http.post(url, headers: headers, body: body);
      }

      return {"status": data.statusCode, "body": json.decode(data.body), "headers": data.headers};
    } catch (e) {
      print(e);
      print("==================================");
      return {"status": 500};
    }
  }

  static Future<LatLng> getCurrentCoordinates() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng currentCoordinates = LatLng(position.latitude, position.longitude);
    return currentCoordinates;
  }
}