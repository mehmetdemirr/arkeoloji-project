import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.grey.shade300,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  cardTheme: const CardTheme(
    color: Colors.white30,
  ),
);
