import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode _theme = ThemeMode.dark;

  Future<void> changeTheme (ThemeMode themeMode) async {
    if (themeMode == _theme) {return;}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _theme = themeMode;
    prefs.setString("theme", _theme == ThemeMode.dark?"Dark" : "Light");
    notifyListeners();
  }

  bool isDark(){
    return _theme == ThemeMode.dark;
  }

  ThemeMode getTheme() {
    return _theme;
  }
}