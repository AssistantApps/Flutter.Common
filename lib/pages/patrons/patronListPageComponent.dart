import 'package:flutter/material.dart';

import '../../components/fun/backgroundWrapper.dart';
import '../../components/grid/searchableGrid.dart';
import '../../components/tilePresenters/patreonTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/ExternalUrls.dart';
import '../../contracts/enum/backgroundType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/json/backupJsonService.dart';

class PatronListPageComponent extends StatelessWidget {
  const PatronListPageComponent({Key? key}) : super(key: key);

  Future<ResultWithValue<List<PatreonViewModel>>> wrapPatronsListCall(
    BuildContext context,
    Future<ResultWithValue<List<PatreonViewModel>>> Function() getPatrons,
  ) async {
    ResultWithValue<List<PatreonViewModel>> patronsResult = await getPatrons();
    if (!patronsResult.isSuccess) return patronsResult;

    List<PatreonViewModel> list = List.empty(growable: true);
    list.addAll(patronsResult.value);
    list.add(PatreonViewModel(
      name: getTranslations().fromKey(LocaleKey.joinPatreon),
      imageUrl: AppImage.onlinePatreonIcon,
      url: ExternalUrls.patreon,
    ));

    return ResultWithValue<List<PatreonViewModel>>(true, list, '');
  }

  @override
  Widget build(BuildContext context) {
    apiFunc() => getAssistantAppsPatreons().getPatrons();
    backupFunc() => BackupJsonService().getPatrons(context);

    return BackgroundWrapper(
      backgroundType: BackgroundType.patreon,
      body: SearchableGrid<PatreonViewModel>(
        () => wrapPatronsListCall(context, apiFunc),
        gridItemDisplayer: patronTilePresenter,
        gridItemSearch: (_, __) => false,
        backupListGetter: () => wrapPatronsListCall(context, backupFunc),
        minListForSearch: 20000,
        addFabPadding: true,
        gridViewColumnCalculator: patreonCustomColumnCount,
      ),
    );
  }
}
