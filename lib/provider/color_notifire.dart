import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorNotifire extends ChangeNotifier {
  static const _key = "isDarkMode";
  bool _isDark = false;

  bool get isDark => _isDark;

  ColorNotifire() {
    _loadTheme(); // cargar al iniciar
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _isDark);
  }
}
