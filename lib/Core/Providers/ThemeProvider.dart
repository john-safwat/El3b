import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode theme = ThemeMode.dark;

  Future<void> changeTheme (ThemeMode themeMode) async {
    if (themeMode == theme) {return;}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = themeMode;
    prefs.setString("theme", theme == ThemeMode.dark?"Dark" : "Light");
    notifyListeners();
  }

  bool isDark(){
    return theme == ThemeMode.dark;
  }

}