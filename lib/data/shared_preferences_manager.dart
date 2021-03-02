import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager._internal();
  static SharedPreferencesManager _singleton;
  static SharedPreferences _sharedPreferences;

  /// shared key
  static const String ACCESS_TOKEN = 'access_token';
  static const String REFRESH_TOKEN = 'refresh_token';

  static Future<SharedPreferencesManager> instance() async {
    if (_sharedPreferences == null) {
      _singleton = SharedPreferencesManager._internal();
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _singleton;
  }

  String get accessToken => _sharedPreferences.getString(ACCESS_TOKEN);
  set accessToken(String accessToken) {
    _sharedPreferences.setString(ACCESS_TOKEN, accessToken);
  }

  String get refreshToken => _sharedPreferences.getString(REFRESH_TOKEN);
  set refreshToken(String refreshToken) {
    _sharedPreferences.setString(REFRESH_TOKEN, refreshToken);
  }
}
