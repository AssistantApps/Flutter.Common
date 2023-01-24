import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget positiveButton(
  BuildContext context, {
  required String title,
  String? eventString,
  EdgeInsets? padding,
  Size? minimumSize,
  Color? backgroundColour,
  Color? foregroundColour,
  Function()? onPress,
}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        backgroundColour ?? getTheme().buttonBackgroundColour(context),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        foregroundColour ?? getTheme().buttonForegroundColour(context),
      ),
      minimumSize: MaterialStateProperty.all<Size?>(minimumSize),
    ),
    onPressed: (onPress != null) ? onPress : null,
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
  );
}

Widget positiveIconButton(
  Color colour, {
  required IconData icon,
  EdgeInsets? padding,
  Function()? onPress,
}) =>
    ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colour),
      ),
      onPressed: (onPress != null) ? onPress : null,
      child: padding == null
          ? Icon(icon)
          : Padding(
              padding: padding,
              child: Icon(icon),
            ),
    );

Widget negativeButton(
    {required String title,
    String? eventString,
    EdgeInsets? padding,
    Color backgroundColour = Colors.red,
    Function()? onPress}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return MaterialButton(
    color: backgroundColour,
    onPressed: (onPress != null) ? onPress : null,
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
  );
}

Widget disabledButton({required String title}) => ElevatedButton(
      onPressed: null,
      child: Text(title),
    );
