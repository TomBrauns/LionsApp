//Licensed under the EUPL v.1.2 or later
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtils {
  static const primaryColor = Color(0xFF00338D);
  static const secondaryColor = Color(0xFFEBB700);
  static final primarySwatch = _createMaterialColor(primaryColor);
  static final secondaryBlue = Color(0xFF94C7FE);
  static final primaryback = Color(0xFFEBF5FA);

  // from: https://stackoverflow.com/questions/50549539/how-to-add-custom-color-to-flutter
  static MaterialColor _createMaterialColor(Color color) {
    final List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
