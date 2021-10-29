import 'package:flutter/material.dart';

import '../../helpers/colourHelper.dart';
import 'interface/IThemeService.dart';

class ThemeService implements IThemeService {
  //
  // Theme
  //
  @override
  ThemeData getTheme(BuildContext context) => ThemeData();
  @override
  Color getPrimaryColour(BuildContext context) => Color(0);
  @override
  Color getSecondaryColour(BuildContext context) => Color(0);
  @override
  Color getDarkModeSecondaryColour() => Color(0);
  @override
  bool getIsDark(BuildContext context) => false;
  @override
  Color getBackgroundColour(BuildContext context) => Color(0);
  @override
  Color getScaffoldBackgroundColour(BuildContext context) => Color(0);
  @override
  void setFontFamily(BuildContext context, String fontFamily) => null;
  @override
  Color getH1Colour(BuildContext context) => Color(0);
  @override
  Color getTextColour(BuildContext context) => Color(0);
  @override
  void setBrightness(BuildContext context, bool isDark) => null;
  @override
  Color getAndroidColour() => HexColor('689f38');
  @override
  Color getIosColour() => HexColor('607d8b');
  @override
  Color getCardTextColour(BuildContext context) => Color(0);
  @override
  Color getCardBackgroundColour(BuildContext context) => Color(0);
  @override
  bool useWhiteForeground(Color backgroundColor) => false;
  @override
  Color getForegroundTextColour(Color backgroundColor) => Color(0);
  @override
  Color fabForegroundColourSelector(BuildContext context) => Color(0);
  @override
  Color fabColourSelector(BuildContext context) => Color(0);
}
