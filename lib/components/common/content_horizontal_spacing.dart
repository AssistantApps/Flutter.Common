import 'package:flutter/material.dart';

import '../../integration/dependency_injection_base.dart';

class ContentHorizontalSpacing extends StatelessWidget {
  final Widget child;

  const ContentHorizontalSpacing({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxWidth = getBaseWidget().tabletBreakpoint();
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < maxWidth) return child;

    double padding = (screenWidth - maxWidth) / 2;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
