import 'package:flutter/material.dart';

import '../../components/grid/searchableGrid.dart';
import '../../components/tilePresenters/steamTilePresenter.dart';
import '../../contracts/enum/assistantAppType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/steamNewsItemViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';

class SteamNewsListPageComponent extends StatelessWidget {
  final AssistantAppType appType;
  final Future<ResultWithValue<List<SteamNewsItemViewModel>>> Function(
      BuildContext) backupFunc;
  SteamNewsListPageComponent(this.appType, {this.backupFunc});

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
