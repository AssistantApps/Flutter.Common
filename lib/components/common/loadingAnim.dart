import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

Widget animateWidgetIn({
  Key key,
  Widget child,
  Duration duration,
}) {
  return Entry.opacity(
    key: key,
    child: child,
    duration: duration ?? Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}
