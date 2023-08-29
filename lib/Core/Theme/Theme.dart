import 'package:flutter/material.dart';

class MyTheme {

  static const Color purple = Color(0xFF37306B);
  static const Color offWhite = Color(0xFFFEFFE8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkPurple = Color(0xFF16132A);
  static const Color lightPurple = Color(0xFF5E53B8);
  static const Color grayPurple = Color(0xFF8F8AB8);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: offWhite
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkPurple
  );

}