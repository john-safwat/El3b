import 'package:flutter/material.dart';

class MyTheme {
  static const Color purple = Color(0xFF37306B);
  static const Color offWhite = Color(0xFFFEFFE8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkPurple = Color(0xFF16132A);
  static const Color lightPurple = Color(0xFF5E53B8);
  static const Color grayPurple = Color(0xFF8F8AB8);

  static ThemeData lightTheme = ThemeData(
      // the screen background
      scaffoldBackgroundColor: offWhite,

      // the elevated button style in thee screen
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(lightPurple),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        textStyle: MaterialStateProperty.all(const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: offWhite)),
      )),

      // all text theme in the app
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 12,
          color: lightPurple,
        ),
        displayMedium: TextStyle(
          fontSize: 16,
          color: lightPurple,
        ),
        displayLarge: TextStyle(
          fontSize: 20,
          color: lightPurple,
        ),
      ),

      // app bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: lightPurple,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(color: lightPurple),
        actionsIconTheme: IconThemeData(color: lightPurple),
      ),
      primaryColor: lightPurple,
      dialogBackgroundColor: MyTheme.offWhite,
      dividerColor: lightPurple,
      textButtonTheme: TextButtonThemeData(style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent))));

  static ThemeData darkTheme = ThemeData(
      // the screen background
      scaffoldBackgroundColor: darkPurple,

      // the elevated button style in thee screen
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(lightPurple),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        textStyle: MaterialStateProperty.all(const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: offWhite)),
      )),

      // all text theme in the app
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 12,
          color: offWhite,
        ),
        displayMedium: TextStyle(
          fontSize: 16,
          color: offWhite,
        ),
        displayLarge: TextStyle(
          fontSize: 20,
          color: offWhite,
        ),
      ),

      // app bar theme
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: offWhite,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(color: offWhite),
        actionsIconTheme: IconThemeData(color: offWhite),
      ),
      primaryColor: offWhite,
      dialogBackgroundColor: purple,
      dividerColor: offWhite,
      textButtonTheme: TextButtonThemeData(style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent))));
}
