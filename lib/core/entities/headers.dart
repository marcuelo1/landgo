import 'package:shared_preferences/shared_preferences.dart';

class Headers {
  static String accessToken = 'access-token';
  static String client = 'client';
  static String uid = 'uid';

  static late SharedPreferences _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Map<String, String> getJson(){
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