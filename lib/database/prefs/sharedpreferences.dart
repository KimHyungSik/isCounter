import 'dart:convert';

import 'package:is_counter/database/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._privateConstructor();

  static final Prefs _sharedpreferences = Prefs._privateConstructor();

  factory Prefs() {
    return _sharedpreferences;
  }

  read(PREFS_KEY key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key.name);
    if (value == null) return null;
    return value;
  }

  save(PREFS_KEY key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key.name, jsonEncode(value));
  }

  remove(PREFS_KEY key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key.name);
  }
}
