import 'package:flutter/material.dart';

/// The Primary Colors of the app
const MaterialColor primaryColor = MaterialColor(400, <int, Color>{
  100: Color(0xFFCDDBB1),
  200: Color(0xFF96BB7C),
  300: Color(0xFF6CAC6E),
  400: Color(0xFF569D77),
  500: Color(0xFF32725B),
  600: Color(0xFF2B6A5E),
});

/// color fade for portion
List<Color?> colorFade = [
  primaryColor[100],
  primaryColor[200],
  primaryColor[300],
  primaryColor[400],
  primaryColor[500],
  primaryColor[600]
];

ColorScheme colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  secondary: primaryColor[100]!,
  onSecondary: primaryColor[200]!,
  surface: Colors.white,
  onSurface: primaryColor[300]!,
  primary: primaryColor[400]!,
  onPrimary: Colors.white,
  inversePrimary: primaryColor[500],
  error: Colors.redAccent[400]!,
  onError: Colors.redAccent[400]!,
  background: Colors.white,
  onBackground: Colors.white70,
);

const double defaultPadding = 18;
