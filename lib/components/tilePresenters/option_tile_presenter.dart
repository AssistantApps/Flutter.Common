import 'package:flutter/material.dart';

import '../../contracts/search/dropdownOption.dart';
import '../../integration/dependencyInjection.dart';
import '../menu/popup_menu.dart';
import './generic_tile_presenter.dart';

Widget optionTilePresenter(
  BuildContext context,
  DropdownOption option, {
  Function()? onDelete,
}) {
  return Card(
    margin: const EdgeInsets.all(0.0),
    child: genericListTile(
      context,
      leadingImage: null,
      name: option.title,
      onTap: () => getNavigation().pop(context, option.value),
      trailing: (onDelete != null)
          ? popupMenu(context, onEdit: null, onDelete: onDelete)
          : null,
    ),
  );
}
