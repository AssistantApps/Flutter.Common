import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../integration/dependencyInjection.dart';

Widget positionedPopupMenu(context,
        {Function()? onEdit, Function()? onDelete}) =>
    Positioned(
      top: 4,
      right: 4,
      child: popupMenu(context, onEdit: onEdit, onDelete: onDelete),
    );

Widget popupMenu(
  context, {
  Function()? onEdit,
  Function()? onDelete,
  Color? iconColour,
  IconData customIcon = Icons.more_vert,
  List<PopupMenuActionItem>? additionalItems,
  Widget? nothingToDisplay,
}) {
  List<PopupMenuActionItem> items = List.empty(growable: true);
  if (onEdit != null) {
    items.add(PopupMenuActionItem(
      icon: Icons.edit,
      onPressed: onEdit,
      text: getTranslations().fromKey(LocaleKey.edit),
    ));
  }

  if (onDelete != null) {
    items.add(PopupMenuActionItem(
      icon: Icons.delete,
      onPressed: onDelete,
      text: getTranslations().fromKey(LocaleKey.delete),
      style: TextStyle(color: Colors.red),
    ));
  }

  if (additionalItems != null && additionalItems.length > 0) {
    items.addAll(additionalItems);
  }
  return popupMenuFromArray(items, iconColour, customIcon, nothingToDisplay);
}

Widget popupMenuFromArray(List<PopupMenuActionItem>? items, Color? iconColour,
    IconData? customIcon, Widget? nothingToDisplay) {
  if (items == null || items.length == 0) {
    return nothingToDisplay ?? Container();
  }
  if (items.length == 1) {
    if (items[0].image != null) {
      return GestureDetector(
        child: items[0].image,
        onTap: items[0].onPressed,
      );
    }
    return IconButton(
      icon: Icon(items[0].icon),
      onPressed: items[0].onPressed,
    );
  }

  return PopupMenuButton<PopupMenuActionItem>(
    onSelected: (PopupMenuActionItem selectedItem) {
      try {
        selectedItem.onPressed();
      } catch (ex) {
        getLog().e(ex.toString());
      }
    },
    icon: Icon(
      customIcon != null ? customIcon : Icons.more_vert,
      color: iconColour,
    ),
    itemBuilder: (BuildContext context) {
      return items
          .map((pi) => PopupMenuItem<PopupMenuActionItem>(
                value: pi,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(pi.icon),
                    ),
                    Text(pi.text, style: pi.style),
                  ],
                ),
              ))
          .toList();
    },
  );
}
