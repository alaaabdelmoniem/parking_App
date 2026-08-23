import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> initInstace() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setValue({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      await prefs.setString(key, value.toString());
    }
  }

  static Object? getValue({required String key}) {
    return prefs.get(key);
  }

  static Future<void> removeValue({required String key}) async {
  await prefs.remove(key);
}
}