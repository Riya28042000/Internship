import 'package:flutter/foundation.dart';
import 'package:regis_login/darkmode.dart/preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  LoginD bdcoe = LoginD();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    bdcoe.setDarkTheme(value);
    notifyListeners();
  }
}