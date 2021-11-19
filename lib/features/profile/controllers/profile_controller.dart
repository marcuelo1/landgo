import 'package:landgo_seller/core/data/shared_preferences_data.dart';

class ProfileController {
  // Private Variables
  Map<String, String> _headers = {};

  // Functions
  void setHeader(){
    _headers = SharedPreferencesData.getHeader();
    print(_headers);
  }

  void getProfileData(){
    
  }
}