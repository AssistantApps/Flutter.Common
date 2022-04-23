import 'package:flutter/material.dart';

final Color themePrimary = Color.fromRGBO(0, 200, 83, 1); // greenAccent[700]
final Color themeSecondary =
    Color.fromRGBO(255, 171, 64, 1); //Colors.orangeAccent[200]
final String themeFontFamily = 'Roboto';

ThemeData darkTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    primaryColor: themePrimary,
    // accentColor: secondary, //DEPRECATED
    colorScheme: base.colorScheme.copyWith(
      primary: themePrimary,
      secondary: themeSecondary,
      secondaryContainer: themeSecondary,
    ),
    textTheme: _buildAppTextTheme(base.textTheme, themeFontFamily),
    primaryTextTheme:
        _buildAppTextTheme(base.primaryTextTheme, themeFontFamily),
    // accentTextTheme: _buildAppTextTheme(base.accentTextTheme, fontFamily), //DEPRECATED
    iconTheme: IconThemeData(color: themeSecondary),
    buttonTheme: ButtonThemeData(
      buttonColor: themeSecondary,
      textTheme: ButtonTextTheme.primary,
    ),
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  );
}

TextTheme _buildAppTextTheme(TextTheme base, String fontFamily) {
  return base
      .copyWith(
        headline5: base.headline5?.copyWith(fontWeight: FontWeight.w900),
        headline6: base.headline6?.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        caption: base.caption?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      )
      .apply(fontFamily: fontFamily);
}
