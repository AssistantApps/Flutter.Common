import 'package:flutter/material.dart';

class IThemeService {
  //
  // Theme
  //
  ThemeData getTheme(BuildContext context) => ThemeData();
  Color getPrimaryColour(BuildContext context) => Color(0);
  Color getSecondaryColour(BuildContext context) => Color(0);
  Color getDarkModeSecondaryColour() => Color(0);
  bool getIsDark(BuildContext context) => false;
  Color getBackgroundColour(BuildContext context) => Color(0);
  Color getScaffoldBackgroundColour(BuildContext context) => Color(0);
  void setFontFamily(BuildContext context, String fontFamily) => null;
  Color getH1Colour(BuildContext context) => Color(0);
  Color getTextColour(BuildContext context) => Color(0);
  void setBrightness(BuildContext context, bool isDark) => null;
  Color getAndroidColour() => Color(0);
  Color getIosColour() => Color(0);
  Color getCardTextColour(BuildContext context) => Color(0);
  Color getCardBackgroundColour(BuildContext context) => Color(0);
  bool useWhiteForeground(Color backgroundColor) => false;
  Color getForegroundTextColour(Color backgroundColor) => Color(0);
  Color fabForegroundColourSelector(BuildContext context) => Color(0);
  Color fabColourSelector(BuildContext context) => Color(0);
  Color buttonBackgroundColour(BuildContext context) => Color(0);
  Color buttonForegroundColour(BuildContext context) => Color(0);
}
