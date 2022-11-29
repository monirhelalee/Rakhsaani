import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static late final SharedPreferences instance;

  /// init sp
  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  /// set data into shared preferences
  static Future<void> setKey(String key, value) async {
    instance.setString(key, value);
  }

  /// get value from shared preferences
  static Future<String?> getKey(String key) async {
    String? value = instance.getString(key);
    return value;
  }
}
