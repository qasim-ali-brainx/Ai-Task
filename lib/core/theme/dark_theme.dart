import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/theme_constants.dart';
import 'base_theme.dart';

ThemeData darkTheme() {
  final ThemeData base = baseTheme();
  return base.copyWith(
    scaffoldBackgroundColor: ColorConstants.backgroundPrimary,
    cardColor: ColorConstants.backgroundCard,
    colorScheme: const ColorScheme.dark(
      primary: ColorConstants.primaryBlue,
      secondary: ColorConstants.accentCyan,
      surface: ColorConstants.backgroundCard,
      error: ColorConstants.statusError,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorConstants.textPrimary,
        fontSize: ThemeConstants.subheadingSize,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConstants.backgroundSecondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
        borderSide: const BorderSide(color: ColorConstants.primaryBlue),
      ),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: ColorConstants.textPrimary,
      displayColor: ColorConstants.textPrimary,
    ),
  );
}
