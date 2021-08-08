import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalVariables {
  static final _headersStorage = FlutterSecureStorage();

  static Future setHeaders (token, client, uid) async {
    print("================================================");
    print(token);
    print(client);
    print(uid);
    await _headersStorage.write(key: 'access-token', value: token);
    await _headersStorage.write(key: 'client', value: client);
    await _headersStorage.write(key: 'uid', value: uid);
  }

  static Future<Map> getHeaders () async {
    return {
      'access-token': await _headersStorage.read(key: 'access-token'),
      'client': await _headersStorage.read(key: 'client'),
      'uid': await _headersStorage.read(key: 'uid')
    };
  }
}