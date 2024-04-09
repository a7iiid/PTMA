import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpreferences;

  staticinit() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<String> putData(String key, String value) async {
    return await sharedpreferences!.setString(key, value) as String;
  }

  static stringgetData(String key) {
    return sharedpreferences!.getString(key) as String;
  }
}
