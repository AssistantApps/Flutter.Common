import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/theme.dart';

class StorybookThemeService implements IThemeService {
  @override
  ThemeData getTheme(BuildContext context) => darkTheme();

  @override
  Color getPrimaryColour(BuildContext context) =>
      getTheme(context).primaryColor;

  @override
  Color getSecondaryColour(BuildContext context) =>
      getTheme(context).colorScheme.secondary;

  @override
  Color getDarkModeSecondaryColour() => darkTheme().colorScheme.secondary;

  @override
  bool getIsDark(BuildContext context) =>
      getTheme(context).brightness == Brightness.dark;

  @override
  Color getBackgroundColour(BuildContext context) =>
      darkTheme().colorScheme.surface;

  @override
  Color getScaffoldBackgroundColour(BuildContext context) =>
      darkTheme().scaffoldBackgroundColor;

  @override
  void setFontFamily(BuildContext context, String fontFamily) {}

  @override
  Color getH1Colour(BuildContext context) {
    var textColour = getTheme(context).textTheme.displayLarge?.color;
    if (textColour == null) {
      return getIsDark(context) ? Colors.white : Colors.black;
    }
    return textColour;
  }

  @override
  Color getTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white : Colors.black;

  @override
  void setBrightness(BuildContext context, bool isDark) {}

  @override
  Color getAndroidColour() => HexColor('689f38');

  @override
  Color getIosColour() => HexColor('607d8b');

  @override
  Color getCardTextColour(BuildContext context) =>
      getIsDark(context) ? Colors.white54 : Colors.black54;

  @override
  Color getCardBackgroundColour(BuildContext context) =>
      darkTheme().colorScheme.surface;

  @override
  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 2.5;

  @override
  Color getForegroundTextColour(Color backgroundColor) =>
      useWhiteForeground(backgroundColor) ? Colors.white : Colors.black;

  @override
  Color fabForegroundColourSelector(BuildContext context) => Colors.white;

  @override
  Color fabColourSelector(BuildContext context) => getPrimaryColour(context);

  @override
  Color buttonBackgroundColour(BuildContext context) =>
      getSecondaryColour(context);

  @override
  Color buttonForegroundColour(BuildContext context) => Colors.black;
}
