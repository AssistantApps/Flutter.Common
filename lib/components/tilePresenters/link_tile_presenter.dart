import 'package:flutter/material.dart';

import '../common/card.dart';
import '../common/image.dart';

Widget linkSettingTilePresenter(
  BuildContext context,
  String name, {
  IconData? icon,
  Function()? onTap,
}) {
  //
  tempOnTap() {
    if (onTap != null) onTap();
  }

  return FlatCard(
    child: ListTile(
      leading: icon != null //
          ? CorrectlySizedImageFromIcon(icon: icon)
          : null,
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: tempOnTap,
    ),
  );
}
