import 'package:animate_do/animate_do.dart';
import 'package:spring/spring.dart';
import 'package:flutter/material.dart';

Widget animateWidgetIn({
  Key? key,
  required Widget child,
  Duration? duration,
}) {
  return FadeIn(
    key: key,
    child: child,
    animate: true,
    manualTrigger: false,
    duration: duration ?? Duration(milliseconds: 500),
  );
}

Widget animateScaleUp({
  required Widget child,
  Duration? duration,
}) {
  return Spring.scale(
    start: 0.2,
    end: 1.0,
    animDuration: duration ?? const Duration(milliseconds: 250),
    child: child,
  );
}

Widget animateSlideInFromLeft({
  Key? key,
  required Widget child,
  Duration? duration,
}) {
  return ElasticInLeft(
    key: key,
    child: child,
    animate: true,
    manualTrigger: false,
    duration: duration ?? Duration(milliseconds: 500),
  );
}
