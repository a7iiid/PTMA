// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeApp {
  static ThemeData themeapplight = ThemeData(
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xffF2F2F2),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
  static ThemeData themeappdark = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 14, 14, 14),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 18, 18, 18),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
