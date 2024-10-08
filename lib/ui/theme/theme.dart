import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 255, 194, 81);
const backgroundColor = Color(0xFFededed);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  hintColor: const Color(0xFF575656),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 148, 148, 148),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
  ),
  textTheme: const TextTheme(
    // headlineLarge: TextStyle(fontFamily: "Bahnschrift"),
    // headlineMedium: TextStyle(fontFamily: "Bahnschrift"),
    // headlineSmall: TextStyle(fontFamily: "Bahnschrift"),
    //
    displaySmall: TextStyle(fontWeight: FontWeight.w300),
  ),
);
