import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightMode =
    ThemeData(brightness: Brightness.light, fontFamily: 'ubuntuRegular');

ThemeData darkMode =
    ThemeData(brightness: Brightness.dark, fontFamily: 'ubuntuRegular');

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences}) : super(ThemeMode.light) {
    _loadThemeModeFromPreferences();
  }

  ThemeData get getThemeData => state.name == 'dark' ? darkMode : lightMode;

  void toggleTheme() {
    final newThemeMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newThemeMode);
    _saveThemeModeToPreferences();
  }

  Future<void> _loadThemeModeFromPreferences() async {
    final savedThemeModeString = sharedPreferences.getString('themeMode');
    if (savedThemeModeString != null) {
      final savedThemeMode = ThemeMode.values.byName(savedThemeModeString);
      emit(savedThemeMode);
    }
  }

  Future<void> _saveThemeModeToPreferences() async {
    await sharedPreferences.setString('themeMode', state.name);
  }
}
