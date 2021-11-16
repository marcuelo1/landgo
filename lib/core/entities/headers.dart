import 'package:shared_preferences/shared_preferences.dart';

class Headers {
  static late String accessToken;
  static late String client;
  static late String uid;

  static late SharedPreferences _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Map getJson(){
    return {
      accessToken: _preferences.getString(accessToken).toString(),
      client: _preferences.getString(client).toString(),
      uid: _preferences.getString(uid).toString(),
    };
  }
  
  static void save(Map json)async{
    // set headers to shared preferences
    await _preferences.setString(accessToken, json['access-token']);
    await _preferences.setString(client, json['client']);
    await _preferences.setString(uid, json['uid']);
  }
}