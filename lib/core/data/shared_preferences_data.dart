import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  // INITIALIZE SHARED PREFERENCES
  static late SharedPreferences _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // HEADERS
  static String accessToken = 'access-token';
  static String client = 'client';
  static String uid = 'uid';

  static Map<String, String> getHeader(){
    return {
      accessToken: _preferences.getString(accessToken).toString(),
      client: _preferences.getString(client).toString(),
      uid: _preferences.getString(uid).toString(),
    };
  }
  
  static void saveHeader(Map json)async{
    // set headers to shared preferences
    await _preferences.setString(accessToken, json['access-token']);
    await _preferences.setString(client, json['client']);
    await _preferences.setString(uid, json['uid']);
  }

  // KEY DATA
  static dynamic getKeyData(String _key){
    return _preferences.get(_key);
  }

  static void saveBoolData(String _key, bool _data)async{
    await _preferences.setBool(_key, _data);
  }

  static void saveStringData(String _key, String _data)async{
    await _preferences.setString(_key, _data);
  }
}