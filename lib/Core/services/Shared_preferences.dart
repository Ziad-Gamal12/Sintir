// ignore_for_file: file_names, camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

abstract class shared_preferences_Services {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> boolSetter(
      {required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  static boolgetter({required String key}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<void> stringSetter(
      {required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  static stringGetter({required String key}) {
    return sharedPreferences.getString(key) ?? " ";
  }
}
