import 'package:flutter/material.dart';
import 'package:note_app/themes/themes.dart';

class ThemesProvider with ChangeNotifier {
  bool isDarkMode = false;

  ThemeData get currentTheme => isDarkMode ? darkMode : lightMode;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
