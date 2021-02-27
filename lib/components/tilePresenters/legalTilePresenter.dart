import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/snapshotHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/base/versionService.dart';
import 'linkTilePresenter.dart';

Widget legalTilePresenter() {
  return FutureBuilder<ResultWithValue<PackageInfo>>(
    future: VersionService().currentAppVersion(),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<PackageInfo>> snapshot) {
      Widget errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;

      return linkSettingTilePresenter(
        context,
        getTranslations().fromKey(LocaleKey.legal),
        icon: Icons.description,
        onTap: () => showAboutDialog(
          context: context,
          applicationLegalese:
              getTranslations().fromKey(LocaleKey.fairUseDisclaimer),
          applicationVersion: snapshot?.data?.value?.version ?? 'v1.0',
        ),
      );
    },
  );
}
