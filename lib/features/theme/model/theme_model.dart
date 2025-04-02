import 'package:flutter/material.dart';

class ThemeModel {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeModel({
    required this.themeData,
    required this.isDarkMode,
  });

  ThemeModel copyWith({
    ThemeData? themeData,
    bool? isDarkMode,
  }) {
    return ThemeModel(
      themeData: themeData ?? this.themeData,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
