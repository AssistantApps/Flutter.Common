import 'package:assistantapps_flutter_common/helpers/genericHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../helpers/updateHelper.dart';

class WhatIsNewDetailPage extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final VersionViewModel version;
  final String pendingAppStoreRelease;
  final Color androidColour;
  final Color iosColour;

  WhatIsNewDetailPage(
    this.currentWhatIsNewGuid,
    this.version,
    this.pendingAppStoreRelease,
    this.androidColour,
    this.iosColour,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = List<Widget>();
    columnWidgets.add(emptySpace(1));

    bool isCurrentVersion =
        version.guid.toLowerCase() == currentWhatIsNewGuid.toLowerCase();

    columnWidgets.add(genericItemText(getVersionReleaseDate(
      context,
      isCurrentVersion,
      this.version.activeDate,
      pendingAppStoreRelease,
    )));

    List<Widget> wrapChildren = List<Widget>();
    for (var plat in this.version.platforms) {
      if (plat == PlatformType.iOS) {
        wrapChildren.add(Chip(
          label: Text('iOS', style: TextStyle(color: Colors.white)),
          backgroundColor: iosColour,
        ));
      }
      if (!isApple) {
        if (plat == PlatformType.Android)
          wrapChildren.add(Chip(
            label: Text('Android', style: TextStyle(color: Colors.white)),
            backgroundColor: androidColour,
          ));
        if (plat == PlatformType.Web) {
          wrapChildren.add(Chip(label: Text('Web')));
        }
      }
    }

    columnWidgets.add(Wrap(
      alignment: WrapAlignment.center,
      children: wrapChildren,
    ));

    columnWidgets.add(MarkdownBody(
      data: this.version.markdown,
      onTapLink: (String link) => launchExternalURL(link),
    ));

    return listWithScrollbar(
      itemCount: columnWidgets.length,
      itemBuilder: (BuildContext context, int index) => columnWidgets[index],
    );
  }
}
