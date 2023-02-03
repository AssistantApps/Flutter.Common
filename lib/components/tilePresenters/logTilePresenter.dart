import 'package:flutter/material.dart';

import '../adaptive/bottom_modal.dart';
import '../modalBottomSheet/logsModalBottomSheet.dart';
import './linkTilePresenter.dart';

Widget logTilePresenter(BuildContext context, {String title = 'Logs'}) {
  return linkSettingTilePresenter(
    context,
    title,
    icon: Icons.code,
    onTap: () => adaptiveBottomModalSheet(
      context,
      hasRoundedCorners: true,
      builder: (BuildContext innerContext) => //
          LogsModalBottomSheet(title: title),
    ),
  );
}
