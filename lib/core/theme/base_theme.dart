import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/theme_constants.dart';

ThemeData baseTheme() {
  return ThemeData(
    useMaterial3: true,
    dividerColor: ColorConstants.borderColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: ThemeConstants.headingSize,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: ThemeConstants.subheadingSize,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: ThemeConstants.bodySize,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontSize: ThemeConstants.captionSize,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
