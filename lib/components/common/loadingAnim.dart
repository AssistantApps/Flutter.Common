import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Widget animateWidgetIn({
  Key key,
  Widget child,
  Duration duration,
}) {
  return FadeIn(
    key: key,
    child: child,
    duration: duration ?? Duration(milliseconds: 500),
  );
}
