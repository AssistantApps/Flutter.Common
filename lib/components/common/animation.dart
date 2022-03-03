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
  Key? key,
  required Widget child,
  Duration? duration,
}) {
  return ZoomIn(
    key: key,
    child: child,
    animate: true,
    manualTrigger: false,
    duration: duration ?? Duration(milliseconds: 500),
  );
  // return Spring.scale(
  //   start: 0.2,
  //   end: 1.0,
  //   animDuration: duration ?? const Duration(milliseconds: 250),
  //   child: child,
  // );
}

Widget animateSlideInFromLeft({
  Key? key,
  required Widget child,
  Duration? duration,
}) {
  // return ElasticInRight(
  //   key: key,
  //   child: child,
  //   animate: true,
  //   manualTrigger: false,
  //   duration: duration ?? Duration(milliseconds: 500),
  // );
  return Spring.slide(
    child: child,
    slideType: SlideType.slide_in_left,
    animDuration: duration ?? Duration(milliseconds: 500),
  );
}
