import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

Widget animateWidgetIn({Key key, Widget child}) {
  return Entry.scale(
    key: key,
    child: child,
    scale: 20,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}
