import 'package:flutter/material.dart';

import '../common/image.dart';

Widget linkSettingTilePresenter(
  BuildContext context,
  String name, {
  IconData icon,
  Function() onTap,
}) {
  //
  void Function() tempOnTap = () {
    if (onTap != null) onTap();
  };

  return Card(
    child: ListTile(
      leading: icon != null //
          ? getCorrectlySizedImageFromIcon(context, icon)
          : null,
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: tempOnTap,
    ),
    margin: const EdgeInsets.all(0.0),
  );
}
