import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferences {
  Sharedpreferences._privateConstructor();

  static final Sharedpreferences _sharedpreferences =
      Sharedpreferences._privateConstructor();

  factory Sharedpreferences() {
    return _sharedpreferences;
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null) return null;
    return json.decode(value);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
