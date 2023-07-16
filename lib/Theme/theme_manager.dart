import 'package:flutter/material.dart';
import 'package:hang_man/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool _isLight = true;
  bool get isLight => _isLight;

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLight = prefs.getBool("theme") ?? true;
    if (_isLight) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  void changeTheme() async {
    logger.d(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_isLight) {
      _themeMode = ThemeMode.dark;
      prefs.setBool("theme", false);
    } else {
      _themeMode = ThemeMode.light;
      prefs.setBool("theme", true);
    }
    _isLight = !_isLight;
    notifyListeners();
  }
}
