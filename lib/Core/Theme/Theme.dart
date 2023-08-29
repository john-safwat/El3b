import 'package:flutter/material.dart';

class MyTheme {

  static const Color purple = Color(0xFF37306B);
  static const Color offWhite = Color(0xFFFEFFE8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkPurple = Color(0xFF16132A);
  static const Color lightPurple = Color(0xFF5E53B8);
  static const Color grayPurple = Color(0xFF8F8AB8);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: offWhite,
    textTheme:const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12 ,
        color: lightPurple,
      ),
      displayMedium: TextStyle(
        fontSize: 16 ,
        color: lightPurple,
      ),
      displayLarge: TextStyle(
        fontSize: 20 ,
        color: lightPurple,
      ),
    )
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkPurple,
      textTheme:const TextTheme(
        displaySmall: TextStyle(
          fontSize: 12 ,
          color: offWhite,
        ),
        displayMedium: TextStyle(
          fontSize: 16 ,
          color: offWhite,
        ),
        displayLarge: TextStyle(
          fontSize: 20 ,
          color: offWhite,
        ),
      )
  );

}