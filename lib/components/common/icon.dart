import 'package:flutter/material.dart';

import '../../integration/dependency_injection.dart';

class IconWithValueRow extends StatelessWidget {
  final IconData icon;
  final int value;

  const IconWithValueRow(this.icon, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(value.toString()),
        )
      ],
    );
  }
}

class IconBackgroundCover extends StatelessWidget {
  final Widget child;
  final Color? backgroundColour;
  final Color? splashColour;
  final BorderRadiusGeometry? borderRadius;

  const IconBackgroundCover({
    Key? key,
    required this.child,
    this.backgroundColour,
    this.splashColour,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColour ?? getTheme().getPrimaryColour(context),
      borderRadius: borderRadius,
      child: InkWell(
        splashColor: splashColour ?? getTheme().getSecondaryColour(context),
        child: SizedBox(
          width: 50,
          height: 50,
          child: child,
        ),
      ),
    );
  }
}
