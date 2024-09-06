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
    animate: true,
    manualTrigger: false,
    duration: duration ?? const Duration(milliseconds: 500),
    child: child,
  );
}

Widget animateScaleUp({
  Key? key,
  required Widget child,
  Duration? duration,
}) {
  return ZoomIn(
    key: key,
    animate: true,
    manualTrigger: false,
    duration: duration ?? const Duration(milliseconds: 500),
    child: child,
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
    animDuration: duration ?? const Duration(milliseconds: 500),
  );
}

class AnimateScaleHeightFrom0ToFull extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimateScaleHeightFrom0ToFull({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  createState() => _AnimateScaleHeightFrom0ToFullState();
}

class _AnimateScaleHeightFrom0ToFullState
    extends State<AnimateScaleHeightFrom0ToFull> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation!,
      axis: Axis.vertical,
      child: widget.child,
    );
  }
}
