import 'package:assistantapps_flutter_common/contracts/generated/appsLinkViewModel.dart';
import 'package:flutter/material.dart';

import '../../contracts/misc/popupMenuaction_item.dart';
import '../menu/popupMenu.dart';
import './genericTilePresenter.dart';

Widget assistantAppLinkPresenter(
  BuildContext context,
  AssistantAppsLinkViewModel appLink,
  String platforms,
  List<PopupMenuActionItem> popups,
) {
  return Card(
    child: genericListTileWithNetworkImage(
      context,
      name: appLink.name,
      imageUrl: appLink.iconUrl,
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
