import 'package:flutter/material.dart';

const primaryColor = Color(0xFF00c27c);
const backgroundColor = Color(0xFFffffff);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  hintColor: const Color(0xFFa2aaa8),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 148, 148, 148),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
  ),
  textTheme: const TextTheme(
    // headlineLarge: TextStyle(fontFamily: "Bahnschrift"),
    headlineMedium: TextStyle(fontWeight: FontWeight.w800),
    // headlineSmall: TextStyle(fontFamily: "Bahnschrift"),
    //
    displaySmall: TextStyle(fontWeight: FontWeight.w300),
  ),
);
