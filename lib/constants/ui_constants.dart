import 'package:flutter/material.dart';

class UIConstants {
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const int donationsPageSize = 20;
  static ShapeBorder noBorderRadius =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
  static const String commonPackage = 'assistantapps_flutter_common';
  static BorderRadius tileLeadingBorderRadius = BorderRadius.circular(4.0);
  static BorderRadius generalBorderRadius = BorderRadius.circular(8.0);
  static const Map<TargetPlatform, PageTransitionsBuilder> pageTransitions = {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
  };
}
