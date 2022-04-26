import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget positiveButton(BuildContext context,
    {required String title,
    String? eventString,
    EdgeInsets? padding,
    Color? backgroundColour,
    Color? foregroundColour,
    Function()? onPress}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return ElevatedButton(
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        backgroundColour ?? getTheme().buttonBackgroundColour(context),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        foregroundColour ?? getTheme().buttonForegroundColour(context),
      ),
    ),
    onPressed: (onPress != null) ? onPress : null,
  );
}

Widget positiveIconButton(Color colour,
        {IconData? icon, Function()? onPress}) =>
    ElevatedButton(
      child: Icon(icon),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colour),
      ),
      onPressed: (onPress != null) ? onPress : null,
    );

Widget negativeButton(
    {required String title,
    String? eventString,
    EdgeInsets? padding,
    Color backgroundColour = Colors.red,
    Function()? onPress}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return MaterialButton(
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
    color: backgroundColour,
    onPressed: (onPress != null) ? onPress : null,
  );
}

Widget disabledButton({required String title}) => ElevatedButton(
      child: Text(title),
      onPressed: null,
    );
