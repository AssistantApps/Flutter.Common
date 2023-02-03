import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../components/list/list_with_scrollbar.dart';
import '../../contracts/enum/platform_type.dart';
import '../../contracts/generated/version_view_model.dart';
import '../../helpers/device_helper.dart';
import '../../helpers/external_helper.dart';
import '../../helpers/update_helper.dart';
import '../../integration/dependencyInjection.dart';

class WhatIsNewDetailPageComponent extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final VersionViewModel version;
  final List<Widget> Function(VersionViewModel)? additionalBuilder;

  const WhatIsNewDetailPageComponent(
    this.currentWhatIsNewGuid,
    this.version, {
    Key? key,
    this.additionalBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgets = List.empty(growable: true);
    columnWidgets.add(const EmptySpace(1));

    bool isCurrentVersion =
        version.guid.toLowerCase() == currentWhatIsNewGuid.toLowerCase();

    columnWidgets.add(GenericItemText(getVersionReleaseDate(
      isCurrentVersion,
      version.activeDate,
    )));

    columnWidgets.add(const EmptySpace(1));

    List<Widget> wrapChildren = List.empty(growable: true);
    for (PlatformType plat in version.platforms) {
      if (plat == PlatformType.apple) {
        wrapChildren.add(getBaseWidget().appChip(
          label: const Text(
            'iOS',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: getTheme().getIosColour(),
        ));
      }
      if (!isApple) {
        if (plat == PlatformType.android) {
          wrapChildren.add(
            getBaseWidget().appChip(
              label: const Text(
                'Android',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: getTheme().getAndroidColour(),
            ),
          );
        }
        if (plat == PlatformType.web) {
          wrapChildren.add(
            getBaseWidget().appChip(
              label: const Text(
                'Web',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.purple,
            ),
          );
        }
        if (plat == PlatformType.githubWindowsInstaller) {
          wrapChildren.add(
            getBaseWidget().appChip(
              label: const Text(
                'Windows',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            ),
          );
        }
      }
    }

    columnWidgets.add(Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: wrapChildren,
    ));
    columnWidgets.add(const EmptySpace2x());

    if (additionalBuilder != null) {
      columnWidgets.addAll(additionalBuilder!(version));
    }

    columnWidgets.add(MarkdownBody(
      data: version.markdown,
      onTapLink: (String text, String? link, String? title) =>
          launchExternalURL(link ?? 'https://assistantapps.com'),
    ));

    return listWithScrollbar(
      itemCount: columnWidgets.length,
      itemBuilder: (BuildContext context, int index) => columnWidgets[index],
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
    );
  }
}
