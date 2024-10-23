import 'package:flutter/material.dart';

import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme(
      primary: primaryColor,
      onPrimary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: primaryColor,
      onSurface: colorBlack,
      secondary: colorGreen,
      onSecondary: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey),
    textTheme: TextTheme(
      labelLarge: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(
        fontSize: 25,
        color: primaryColor,
      ),
    ),
  );
}
