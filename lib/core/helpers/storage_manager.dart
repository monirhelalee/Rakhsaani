import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// set data into shared preferences
  Future<void> setKey(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// get value from shared preferences
  Future<String?> getKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    return value;
  }
}