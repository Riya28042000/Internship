import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Styles {


  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
   primaryColor: isDarkTheme ? Colors.black : Colors.white,
  backgroundColor: isDarkTheme?Color(0xff2479a7):Color(0xff155cb0),
  textSelectionColor: isDarkTheme?Colors.white:Colors.black,
cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
    );
  }
}