// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_returning_null_for_void

import 'package:flutter/material.dart';

import '../../helpers/colourHelper.dart';
import './interface/IThemeService.dart';

class ThemeService implements IThemeService {
  //
  // Theme
  //
  @override
  ThemeData getTheme(BuildContext context) => ThemeData();
  @override
  Color getPrimaryColour(BuildContext context) => const Color(0);
  @override
  Color getSecondaryColour(BuildContext context) => const Color(0);
  @override
  Color getDarkModeSecondaryColour() => const Color(0);
  @override
  bool getIsDark(BuildContext context) => false;
  @override
  Color getBackgroundColour(BuildContext context) => const Color(0);
  @override
  Color getScaffoldBackgroundColour(BuildContext context) => const Color(0);
  @override
  void setFontFamily(BuildContext context, String fontFamily) => null;
  @override
  Color getH1Colour(BuildContext context) => const Color(0);
  @override
  Color getTextColour(BuildContext context) => const Color(0);
  @override
  void setBrightness(BuildContext context, bool isDark) => null;
  @override
  Color getAndroidColour() => HexColor('689f38');
  @override
  Color getIosColour() => HexColor('607d8b');
  @override
  Color getCardTextColour(BuildContext context) => const Color(0);
  @override
  Color getCardBackgroundColour(BuildContext context) => const Color(0);
  @override
  bool useWhiteForeground(Color backgroundColor) => false;
  @override
  Color getForegroundTextColour(Color backgroundColor) => const Color(0);
  @override
  Color fabForegroundColourSelector(BuildContext context) => const Color(0);
  @override
  Color fabColourSelector(BuildContext context) => const Color(0);
  @override
  Color buttonBackgroundColour(BuildContext context) => const Color(0);
  @override
  Color buttonForegroundColour(BuildContext context) => const Color(0);
}
