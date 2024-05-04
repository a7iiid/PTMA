import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future putData(String key, String value) async {
    await sharedpreferences!.setString(key, value);
  }

  static String getData(String key) {
    final value = sharedpreferences?.getString(key);
    return value ?? '';
  }

  static Future<bool> langPutData(String key, bool value) async {
    return await sharedpreferences!.setBool(key, value);
  }

  static langGetData(String key) {
    final value = sharedpreferences?.getBool(key);
    if (value == null) return false;

    return sharedpreferences!.getBool(key) as bool;
  }
}
