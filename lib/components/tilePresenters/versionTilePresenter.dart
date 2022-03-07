import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../assistantapps_flutter_common.dart';
import '../../services/base/versionService.dart';

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
    IconData? iconToDisplay = getVersionIcon(
      isCurrentVersion,
      version.activeDate,
    );

    Widget child = timelineTilePresenter(
      context,
      genericListTileWithSubtitle(
        context,
        leadingImage: null,
        name: getTranslations()
            .fromKey(LocaleKey.release)
            .replaceAll('{0}', version.buildName),
        subtitle: genericEllipsesText(dateToDisplay),
        trailing: Icon(Icons.chevron_right),
        onTap: () => onTap(version),
      ),
      hideTopConnector: index == 0,
      customIndicatorIcon: iconToDisplay,
    );

    Widget paddedChild = Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: child,
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return wrapInNewBanner(context, LocaleKey.current, paddedChild);
    }
    return paddedChild;
  };
  return presenter;
}

Widget packageVersionTile(String gameVersion, {Function()? onTap}) {
  return FutureBuilder<ResultWithValue<PackageInfo>>(
    future: VersionService().currentAppVersion(),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<PackageInfo>> snapshot) {
      Widget? errorWidget = asyncSnapshotHandler(context, snapshot,
          loader: () => getLoading().loadingIndicator());
      if (errorWidget != null) return Container();

      ResultWithValue<PackageInfo>? packageInfoResult = snapshot.data;
      String appVersionString = getTranslations() //
          .fromKey(LocaleKey.appVersion)
          .replaceAll('{0}', packageInfoResult?.value.version ?? '1.0');
      Widget gameVersionWidget = Text(
        getTranslations()
            .fromKey(LocaleKey.gameVersion)
            .replaceAll('{0}', gameVersion),
      );

      Widget titleWidget = gameVersionWidget;
      Widget? subtitleWidget;
      if ((packageInfoResult?.isSuccess == true) &&
          packageInfoResult?.value != null) {
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
