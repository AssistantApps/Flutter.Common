import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget placeholderImage(
  BuildContext context, {
  double? width,
  double? height,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  void Function()? onTap,
}) {
  return SizedBox(
    width: width ?? 100,
    height: height ?? 100,
    child: Padding(
      padding: EdgeInsets.only(top: 12, left: 4, right: 4, bottom: 4),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        dashPattern: [8, 4],
        color: getTheme().getSecondaryColour(context),
        child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Center(
              child: Icon(Icons.image, size: 50),
            ),
          ),
          onTap: () {
            if (onTap != null) onTap();
          },
        ),
      ),
    ),
  );
}

Widget placeholderFullRow(
  BuildContext context, {
  double? width,
  double? height,
  IconData? icon,
  void Function()? onTap,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.only(top: 12, left: 4, right: 4, bottom: 4),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        dashPattern: [8, 4],
        color: getTheme().getSecondaryColour(context),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Center(
            child: SizedBox(
              width: width ?? 75,
              height: height ?? 75,
              child: Center(child: Icon(icon, size: 50)),
            ),
          ),
        ),
      ),
    ),
    onTap: () {
      if (onTap != null) onTap();
    },
  );
}
