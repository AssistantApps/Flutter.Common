import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/version_view_model.dart';
import '../../contracts/misc/version_detail.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/snapshot_helper.dart';
import '../../helpers/update_helper.dart';
import '../../integration/dependency_injection.dart';
import '../common/image.dart';
import '../common/new_banner.dart';
import '../common/text.dart';
import './generic_tile_presenter.dart';
import './timeline_tile_item_presenter.dart';

Widget Function(
  BuildContext context,
  VersionViewModel version,
  int index,
  int totalRows,
) versionTilePresenter(
  BuildContext context,
  String versionGuid,
  void Function(VersionViewModel) onTap,
) {
  presenter(
    BuildContext context,
    VersionViewModel version,
    int index,
    int totalRows,
  ) {
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
        subtitle: GenericEllipsesText(dateToDisplay),
        trailing: const Icon(Icons.chevron_right),
      ),
      hideTopConnector: index == 0,
      hideBottomConnector: index == totalRows,
      customIndicatorIcon: iconToDisplay,
    );

    Widget paddedChild = InkWell(
      onTap: () => onTap(version),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: child,
      ),
    );
    if (version.guid.toLowerCase() == versionGuid.toLowerCase()) {
      return WrapInNewBanner(message: LocaleKey.current, child: paddedChild);
    }
    return paddedChild;
  }

  return presenter;
}

Widget packageVersionTile(String gameVersion, {Function()? onTap}) {
  return FutureBuilder<ResultWithValue<VersionDetail>>(
    future: getUpdate().getPackageInfo(),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<VersionDetail>> snapshot) {
      Widget? errorWidget = asyncSnapshotHandler(context, snapshot,
          loader: () => getLoading().loadingIndicator());
      if (errorWidget != null) return Container();

      ResultWithValue<VersionDetail>? packageInfoResult = snapshot.data;
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
        key: const Key('versionNumber'),
        leading: const CorrectlySizedImageFromIcon(icon: Icons.code),
        title: titleWidget,
        subtitle: subtitleWidget,
        onTap: onTap,
        dense: true,
      );
    },
  );
}
