import 'package:flutter/material.dart';
import '../services/prefs_service.dart';

class AppState extends ChangeNotifier {
  final PrefsService _prefs;
  ThemeMode _themeMode = ThemeMode.system;
  bool _loggedIn = false; // demo-only session

  AppState(this._prefs);

  ThemeMode get themeMode => _themeMode;
  bool get loggedIn => _loggedIn;

  Future<void> load() async {
    final mode = await _prefs.getThemeMode();
    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setThemeMode(switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
    notifyListeners();
  }

  void demoLogin() {
    _loggedIn = true;
    notifyListeners();
  }

  void demoLogout() {
    _loggedIn = false;
    notifyListeners();
  }
}
