import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'theme_mode';


  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

    IconData get currentIcon =>
      state == ThemeMode.light ? Icons.dark_mode : Icons.light_mode;

  void toggleTheme() {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    _saveTheme(newTheme);
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_themeKey);
    if (saved != null) {
      emit(ThemeMode.values.firstWhere((e) => e.name == saved));
    }
  }

  void getTheme() {}
}
