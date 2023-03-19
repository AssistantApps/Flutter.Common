import 'package:assistantapps_flutter_common/contracts/generated/apps_link_view_model.dart';
import 'package:flutter/material.dart';

import './generic_tile_presenter.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/misc/popup_menu_action_item.dart';
import '../menu/popup_menu.dart';

Widget assistantAppLinkPresenter(
  BuildContext context,
  AssistantAppsLinkViewModel appLink,
  String platforms,
  List<PopupMenuActionItem> popups,
) {
  return Card(
    child: genericListTileWithNetworkImage(
      context,
      name: appLink.title,
      imageUrl: appLink.icon,
      borderRadius: UIConstants.tileLeadingBorderRadius,
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
      // onTap: (appLink.home != null)
      //     ? () => launchExternalURL(appLink.home)
      //     : () {},
    ),
  );
}
