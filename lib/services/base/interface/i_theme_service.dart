// ignore_for_file: avoid_returning_null_for_void, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class IThemeService {
  //
  // Theme
  //
  ThemeData getTheme(BuildContext context) => ThemeData();
  Color getPrimaryColour(BuildContext context) => const Color(0);
  Color getSecondaryColour(BuildContext context) => const Color(0);
  Color getDarkModeSecondaryColour() => const Color(0);
  bool getIsDark(BuildContext context) => false;
  Color getBackgroundColour(BuildContext context) => const Color(0);
  Color getScaffoldBackgroundColour(BuildContext context) => const Color(0);
  void setFontFamily(BuildContext context, String fontFamily) => null;
  Color getH1Colour(BuildContext context) => const Color(0);
  Color getTextColour(BuildContext context) => const Color(0);
  void setBrightness(BuildContext context, bool isDark) => null;
  Color getAndroidColour() => const Color(0);
  Color getIosColour() => const Color(0);
  Color getCardTextColour(BuildContext context) => const Color(0);
  Color getCardBackgroundColour(BuildContext context) => const Color(0);
  bool useWhiteForeground(Color backgroundColor) => false;
  Color getForegroundTextColour(Color backgroundColor) => const Color(0);
  Color fabForegroundColourSelector(BuildContext context) => const Color(0);
  Color fabColourSelector(BuildContext context) => const Color(0);
  Color buttonBackgroundColour(BuildContext context) => const Color(0);
  Color buttonForegroundColour(BuildContext context) => const Color(0);
}
