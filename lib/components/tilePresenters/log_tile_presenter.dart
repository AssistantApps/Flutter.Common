import 'package:flutter/material.dart';

import '../adaptive/bottom_modal.dart';
import '../modalBottomSheet/logs_modal_bottom_sheet.dart';
import './link_tile_presenter.dart';

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
