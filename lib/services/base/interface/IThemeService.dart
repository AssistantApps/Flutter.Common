import 'package:flutter/material.dart';

class IThemeService {
  ThemeData getTheme(BuildContext context) => ThemeData();
  Color getPrimaryColour(BuildContext context) => Color(0);
  Color getSecondaryColour(BuildContext context) => Color(0);
  Color getDarkModeSecondaryColour() => Color(0);
  bool getIsDark(BuildContext context) => false;
  Color getBackgroundColour(BuildContext context) => Color(0);
  Color getScaffoldBackgroundColour(BuildContext context) => Color(0);
  Color getH1Colour(BuildContext context) => Color(0);
  Color getTextColour(BuildContext context) => Color(0);
  void setBrightness(BuildContext context, bool isDark) => null;
  Color getAndroidColour() => Color(0);
  Color getIosColour() => Color(0);
}
