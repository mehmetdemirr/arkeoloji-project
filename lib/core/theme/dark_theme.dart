import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.blueGrey.shade300,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  cardTheme: const CardTheme(
    color: Colors.blueGrey,
  ),
);
