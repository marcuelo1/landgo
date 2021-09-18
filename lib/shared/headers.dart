import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Headers {
  static late SharedPreferences _preferences;
  static const String accessToken = "access-token";
  static const String client = "client";
  static const String uid = "uid";
  static const String headersFileName = "headers.txt";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setHeaders(Map headers) async {
    // set headers to shared preferences
    await _preferences.setString(accessToken, headers['access-token']);
    await _preferences.setString(client, headers['client']);
    await _preferences.setString(uid, headers['uid']);
  }

  static Map<String, String> getHeaders(){
    return {
      accessToken: _preferences.getString(accessToken).toString(),
      client: _preferences.getString(client).toString(),
      uid: _preferences.getString(uid).toString(),
    };
  }
}