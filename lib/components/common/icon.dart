import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget iconWithValueRow(IconData icon, int value) {
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

Widget iconBackgroundCover(BuildContext context, Widget child,
    {Color? backgroundColour,
    Color? splashColour,
    BorderRadiusGeometry? borderRadius}) {
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
