import 'package:flutter/material.dart';

Widget positiveButton(
    {String title, String eventString, EdgeInsets padding, Function onPress}) {
  var textWidget = Text(title, textAlign: TextAlign.center);
  return RaisedButton(
    child: padding == null
        ? textWidget
        : Padding(
            padding: padding,
            child: textWidget,
          ),
    onPressed: (onPress != null) ? onPress : null,
  );
}

Widget negativeButton(
    {String title, String eventString, EdgeInsets padding, Function onPress}) {
  var textWidget = Text(title, textAlign: TextAlign.center);
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

Widget disabledButton({String title}) => RaisedButton(
      child: Text(title),
      onPressed: null,
    );
