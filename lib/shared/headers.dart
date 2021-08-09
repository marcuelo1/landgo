import 'package:shared_preferences/shared_preferences.dart';

class Headers {
  static late SharedPreferences _preferences;
  static const String accessToken = "access-token";
  static const String client = "client";
  static const String uid = "uid";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setHeaders(Map headers) async {
    await _preferences.setString(accessToken, headers['access-token']);
    await _preferences.setString(client, headers['client']);
    await _preferences.setString(uid, headers['uid']);
  }

  static Map getHeaders(){
    return {
      accessToken: _preferences.getString(accessToken),
      client: _preferences.getString(client),
      uid: _preferences.getString(uid),
    };
  }
}