import 'package:flutter/material.dart';

import '../../components/grid/searchable_grid.dart';
import '../../components/tilePresenters/steam_tile_presenter.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/steam_news_item_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/column_helper.dart';
import '../../integration/dependency_injection.dart';

class SteamNewsListPageComponent extends StatelessWidget {
  final AssistantAppType appType;
  final Future<ResultWithValue<List<SteamNewsItemViewModel>>> Function(
      BuildContext) backupFunc;

  const SteamNewsListPageComponent(
    this.appType, {
    super.key,
    required this.backupFunc,
  });

  @override
  Widget build(BuildContext context) {
    return SearchableGrid<SteamNewsItemViewModel>(
      () => getAssistantAppsSteam().getSteamNews(appType),
      gridItemWithIndexDisplayer: steamNewsItemTilePresenter,
      gridItemSearch: (_, __) => false,
      backupListGetter: () => backupFunc(context),
      backupListWarningMessage: LocaleKey.failedLatestDisplayingOld,
      gridViewColumnCalculator: steamNewsCustomColumnCount,
      minListForSearch: 20000,
    );
  }
}
