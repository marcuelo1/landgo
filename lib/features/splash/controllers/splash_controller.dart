import 'package:landgo_seller/core/data/shared_preferences_data.dart';

class SplashController {
  static String isLoggedInString = 'is_logged_in';

  bool isLoggedIn(){
    if (SharedPreferencesData.getKeyData(isLoggedInString) == null){
      return false;
    }else{
      return SharedPreferencesData.getKeyData(isLoggedInString);
    }
  }
}