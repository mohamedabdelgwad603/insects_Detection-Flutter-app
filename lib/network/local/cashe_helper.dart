import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(String key, dynamic value) {
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    return sharedPreferences.setDouble(key, value);
  }

  static getData(String key) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData(String key) {
    return sharedPreferences.remove(key);
  }
}
