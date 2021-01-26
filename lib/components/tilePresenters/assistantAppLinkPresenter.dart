import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/data/assistantAppLinks.dart';
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../helpers/externalHelper.dart';
import '../menu/popupMenu.dart';
import 'genericTilePresenter.dart';

Widget assistantAppLinkPresenter(
  BuildContext context,
  AssistantAppLinks appLink,
  String platforms,
  List<PopupMenuActionItem> popups,
) {
  return Card(
    child: ListTile(
      leading: genericTileImage(
        '${AppImage.base}icon/${appLink.icon}',
        imagePackage: UIConstants.CommonPackage,
      ),
      title: Text(
        appLink.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        platforms,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: popupMenu(
        context,
        customIcon: Icons.open_in_new,
        additionalItems: popups,
      ),
      onTap: (appLink.home != null)
          ? () => launchExternalURL(appLink.home)
          : () {},
    ),
  );
}
