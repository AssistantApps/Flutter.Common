import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/updateHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/base/versionService.dart';
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

Widget packageVersionTile(String gameVersion, {Function() onTap}) {
  return FutureBuilder<ResultWithValue<PackageInfo>>(
    future: VersionService().currentAppVersion(),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<PackageInfo>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot,
          loader: () => getLoading().loadingIndicator());
      if (errorWidget != null) return Container();

      ResultWithValue<PackageInfo> packageInfoResult = snapshot.data;
      String appVersionString = getTranslations() //
          .fromKey(LocaleKey.appVersion)
          .replaceAll('{0}', packageInfoResult?.value?.version ?? '1.0');
      Widget gameVersionWidget = Text(
        getTranslations()
            .fromKey(LocaleKey.gameVersion)
            .replaceAll('{0}', gameVersion),
      );

      Widget titleWidget = gameVersionWidget;
      Widget subtitleWidget;
      if (packageInfoResult.isSuccess && packageInfoResult.value != null) {
        titleWidget = Text(appVersionString);
        subtitleWidget = gameVersionWidget;
      }

      return ListTile(
        key: Key('versionNumber'),
        leading: getCorrectlySizedImageFromIcon(context, Icons.code),
        title: titleWidget,
        subtitle: subtitleWidget,
        onTap: onTap,
        dense: true,
      );
    },
  );
}
