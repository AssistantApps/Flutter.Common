import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../contracts/generated/versionViewModel.dart';
import '../../helpers/updateHelper.dart';
import '../common/newBanner.dart';
import '../common/text.dart';
import 'genericTilePresenter.dart';

Widget Function(BuildContext context, VersionViewModel version)
    versionTilePresenter(
  BuildContext context,
  String versionGuid,
  String release,
  String current,
  String pendingAppStoreRelease,
  Color lineColour,
  void Function(VersionViewModel) onTap,
) {
  return (BuildContext context, VersionViewModel version) {
    bool isCurrentVersion =
        version.guid.toLowerCase() == versionGuid.toLowerCase();
    String dateToDisplay = getVersionReleaseDate(
      context,
      isCurrentVersion,
      version.activeDate,
      pendingAppStoreRelease,
    );

    var child = TimelineTile(
      alignment: TimelineAlign.left,
      rightChild: genericListTileWithSubtitle(
        context,
        leadingImage: null,
        name: release.replaceAll('{0}', version.buildName),
        subtitle: genericEllipsesText(dateToDisplay),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
      indicatorStyle: IndicatorStyle(width: 25, color: lineColour),
      topLineStyle: LineStyle(color: lineColour),
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return wrapInNewBanner(context, current, child);
    }
    return child;
  };
}
