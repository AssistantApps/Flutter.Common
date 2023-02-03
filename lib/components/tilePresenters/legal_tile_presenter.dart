import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../contracts/misc/version_detail.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/snapshotHelper.dart';
import '../../integration/dependencyInjection.dart';
import './link_tile_presenter.dart';

Widget legalTilePresenter({LocaleKey? description}) {
  return FutureBuilder<ResultWithValue<VersionDetail>>(
    future: getUpdate().getPackageInfo(),
    builder: (BuildContext context,
        AsyncSnapshot<ResultWithValue<VersionDetail>> snapshot) {
      Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
      if (errorWidget != null) return errorWidget;

      return linkSettingTilePresenter(
        context,
        getTranslations().fromKey(LocaleKey.legal),
        icon: Icons.description,
        onTap: () => showAboutDialog(
          context: context,
          applicationLegalese:
              getTranslations().fromKey(description ?? LocaleKey.legalNotice),
          applicationVersion: snapshot.data?.value.version ?? 'v1.0',
        ),
      );
    },
  );
}
