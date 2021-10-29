import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../components/list/listWithScrollbar.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../helpers/updateHelper.dart';
import '../../integration/dependencyInjection.dart';

class WhatIsNewDetailPageComponent extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final VersionViewModel version;
  final List<Widget> Function(VersionViewModel) additionalBuilder;

  WhatIsNewDetailPageComponent(
    this.currentWhatIsNewGuid,
    this.version, {
    this.additionalBuilder,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = List.empty(growable: true);
    columnWidgets.add(emptySpace(1));

    bool isCurrentVersion =
        version.guid.toLowerCase() == currentWhatIsNewGuid.toLowerCase();

    columnWidgets.add(genericItemText(getVersionReleaseDate(
      isCurrentVersion,
      this.version.activeDate,
    )));

    columnWidgets.add(emptySpace(1));

    List<Widget> wrapChildren = List.empty(growable: true);
    for (PlatformType plat in this.version.platforms) {
      if (plat == PlatformType.Apple) {
        wrapChildren.add(Chip(
          label: Text('iOS', style: TextStyle(color: Colors.white)),
          backgroundColor: getTheme().getIosColour(),
        ));
      }
      if (!isApple) {
        if (plat == PlatformType.Android)
          wrapChildren.add(Chip(
            label: Text('Android', style: TextStyle(color: Colors.white)),
            backgroundColor: getTheme().getAndroidColour(),
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

    if (additionalBuilder != null) {
      columnWidgets.addAll(additionalBuilder(this.version));
    }

    columnWidgets.add(MarkdownBody(
      data: this.version.markdown,
      onTapLink: (String text, String link, String title) =>
          launchExternalURL(link),
    ));

    return listWithScrollbar(
      itemCount: columnWidgets.length,
      itemBuilder: (BuildContext context, int index) => columnWidgets[index],
    );
  }
}
