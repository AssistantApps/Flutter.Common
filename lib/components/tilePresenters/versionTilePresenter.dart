import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../helpers/updateHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../common/newBanner.dart';
import '../common/text.dart';
import 'genericTilePresenter.dart';

Widget Function(BuildContext context, VersionViewModel version, int index)
    versionTilePresenter(
  BuildContext context,
  String versionGuid,
  void Function(VersionViewModel) onTap,
) {
  Widget Function(BuildContext, VersionViewModel, int index) presenter =
      (BuildContext context, VersionViewModel version, int index) {
    bool isCurrentVersion =
        version.guid.toLowerCase() == versionGuid.toLowerCase();
    String dateToDisplay = getVersionReleaseDate(
      isCurrentVersion,
      version.activeDate,
    );

    TimelineTile child = TimelineTile(
      alignment: TimelineAlign.start,
      endChild: genericListTileWithSubtitle(
        context,
        leadingImage: null,
        name: getTranslations()
            .fromKey(LocaleKey.release)
            .replaceAll('{0}', version.buildName),
        subtitle: genericEllipsesText(dateToDisplay),
        trailing: Icon(Icons.chevron_right),
        onTap: () => onTap(version),
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        color: getTheme().getSecondaryColour(context),
      ),
      beforeLineStyle: LineStyle(color: getTheme().getSecondaryColour(context)),
      isFirst: index == 0,
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return wrapInNewBanner(context, LocaleKey.current, child);
    }
    return child;
  };
  return presenter;
}
