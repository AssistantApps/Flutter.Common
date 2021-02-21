import 'package:flutter/material.dart';

Widget positiveButton(
    {String title,
    String eventString,
    EdgeInsets padding,
    Color colour,
    Function onPress}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return ElevatedButton(
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(colour),
    ),
    onPressed: (onPress != null) ? onPress : null,
  );
}

Widget positiveIconButton(Color colour, {IconData icon, Function onPress}) =>
    ElevatedButton(
      child: Icon(icon),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colour),
      ),
      onPressed: (onPress != null) ? onPress : null,
    );

Widget negativeButton(
    {String title, String eventString, EdgeInsets padding, Function onPress}) {
  Text textWidget = Text(title, textAlign: TextAlign.center);
  return MaterialButton(
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
    color: Colors.red,
    onPressed: (onPress != null) ? onPress : null,
  );
}

Widget disabledButton({String title}) => ElevatedButton(
      child: Text(title),
      onPressed: null,
    );
