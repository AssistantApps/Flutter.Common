import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import 'genericTilePresenter.dart';

Widget optionTilePresenter(BuildContext context, DropdownOption option,
    {Function onDelete}) {
  return Card(
    child: genericListTile(
      context,
      leadingImage: null,
      name: option.title,
      onTap: () => getNavigation().pop(context, option.value),
      trailing: (onDelete != null)
          ? popupMenu(context, onEdit: null, onDelete: onDelete)
          : null,
    ),
    margin: const EdgeInsets.all(0.0),
  );
}
