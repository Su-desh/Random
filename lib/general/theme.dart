// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/main.dart';

ThemeData light_mode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
);

ThemeData dark_mode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
);

class ThemeNotifier extends GetxController {
  final String key = 'theme';
  bool? _lightMode;
  bool? get lightMode => _lightMode;

  ThemeNotifier() {
    _lightMode = true;
    _loadFromPreferences();
  }

  void _savePreferences() {
    sharedPreferences.setBool(key, _lightMode!);
  }

  void _loadFromPreferences() {
    _lightMode = sharedPreferences.getBool(key) ?? true;
    update();
  }

  void toggleChangeTheme() {
    _lightMode = !_lightMode!;
    _savePreferences();
    update();
  }
}
