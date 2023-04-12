import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../pages/misc/logs_view_page.dart';

Widget logTilePresenter(
  BuildContext context, {
  String title = 'Logs',
  bool useModalBottomSheet = false,
}) {
  return linkSettingTilePresenter(
    context,
    title,
    icon: Icons.code,
    onTap: () {
      if (useModalBottomSheet) {
        adaptiveBottomModalSheet(
          context,
          hasRoundedCorners: true,
          builder: (BuildContext innerContext) => //
              LogsModalBottomSheet(title: title),
        );
        return;
      }

      getNavigation().navigateAwayFromHomeAsync(
        context,
        navigateTo: (navCtx) => LogsViewPage(title: title),
      );
    },
  );
}
