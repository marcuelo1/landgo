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
    
    // // get headers from headers style
    // List headers = await readHeaders();

    // if(headers.length == 3){
    //   // format "access-token,client,uid"
    //   await _preferences.setString(accessToken, headers[0]);
    //   await _preferences.setString(client, headers[1]);
    //   await _preferences.setString(uid, headers[2]);
    // }
  }

  static Future setHeaders(Map headers) async {
    // set headers to shared preferences
    await _preferences.setString(accessToken, headers['access-token']);
    await _preferences.setString(client, headers['client']);
    await _preferences.setString(uid, headers['uid']);

    // // set headers to headers txt file
    // writeHeaders(headers['access-token'], headers['client'], headers['uid']);
  }

  static Map getHeaders(){
    return {
      accessToken: _preferences.getString(accessToken),
      client: _preferences.getString(client),
      uid: _preferences.getString(uid),
    };
  }

  // file functions
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    // // check if headers file exist
    // bool checkFile = await File('$path/$headersFileName').exists();
    // if(!checkFile){
    //   return new File('$path/$headersFileName');
    // }
    return File('$path/$headersFileName');
  }

  static Future<File> writeHeaders(String accessToken, String client, String uid) async {
    final file = await _localFile;

    // Write the file
    // format "access-token,client,uid"
    return file.writeAsString('$accessToken,$client,$uid');
  }

  static Future<List> readHeaders() async {
    try {
      final file = await _localFile;

      // Read the file
      final headers = await file.readAsString();

      return headers.split(',');
    } catch (e) {
      // If encountering an error, return []
      return [];
    }
  }
}