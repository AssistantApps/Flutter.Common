import 'package:flutter/material.dart';

import '../common/image.dart';

ListTile genericListTileWithSubtitle(context,
    {@required String leadingImage,
    String imageBackgroundColour,
    bool imageGreyScale = false,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  if (title == null || title.length == 0) title = ' ';

  return ListTile(
    leading: genericTileImage(leadingImage),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    // dense: true,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

ListTile genericListTileWithNetworkImage(context,
    {@required String imageUrl,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  return ListTile(
    leading: networkImage(
      imageUrl,
      boxfit: BoxFit.contain,
      height: 50.0,
      width: 50.0,
    ),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    //dense: true,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

Widget genericTileImage(String leadingImage) {
  if (leadingImage == null) return null;

  String prefix = '';
  if (!leadingImage.contains('assets/images')) {
    prefix = 'assets/images/';
  }

  String fullPath = '$prefix$leadingImage';
  return localImage(fullPath);
}
