import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../helpers/updateHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../common/newBanner.dart';
import '../common/text.dart';
import 'genericTilePresenter.dart';

Widget Function(BuildContext context, VersionViewModel version)
    versionTilePresenter(
  BuildContext context,
  String versionGuid,
  void Function(VersionViewModel) onTap,
) {
  return (BuildContext context, VersionViewModel version) {
    bool isCurrentVersion =
        version.guid.toLowerCase() == versionGuid.toLowerCase();
    String dateToDisplay = getVersionReleaseDate(
      isCurrentVersion,
      version.activeDate,
    );

    var child = TimelineTile(
      alignment: TimelineAlign.left,
      rightChild: genericListTileWithSubtitle(
        context,
        leadingImage: null,
        name: Translations.fromKey(LocaleKey.release)
            .replaceAll('{0}', version.buildName),
        subtitle: genericEllipsesText(dateToDisplay),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        color: getTheme().getSecondaryColour(context),
      ),
      topLineStyle: LineStyle(color: getTheme().getSecondaryColour(context)),
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return wrapInNewBanner(context, LocaleKey.current, child);
    }
    return child;
  };
}
