import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget genericChip(context, String title, {Color? color, Function()? onTap}) {
  var child = Padding(
    child: Chip(
      label: Text(title),
      backgroundColor: color ?? getTheme().getSecondaryColour(context),
    ),
    padding: EdgeInsets.only(left: 4),
  );
  return (onTap == null) ? child : InkWell(child: child, onTap: onTap);
}
