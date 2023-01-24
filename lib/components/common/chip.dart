import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget genericChip(context, String title, {Color? color, Function()? onTap}) {
  var child = Padding(
    padding: const EdgeInsets.only(left: 4),
    child: Chip(
      label: Text(title),
      backgroundColor: color ?? getTheme().getSecondaryColour(context),
    ),
  );
  return (onTap == null)
      ? child
      : InkWell(
          onTap: onTap,
          child: child,
        );
}
