import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../components/tilePresenters/patreonTilePresenter.dart';
import '../../constants/AppImage.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
        child: SearchableGrid<PatreonViewModel>(
          () => wrapPatronsListCall(context, apiFunc),
          gridItemDisplayer: patronTilePresenter,
          gridItemSearch: (_, __) => false,
          backupListGetter: () => wrapPatronsListCall(context, backupFunc),
          minListForSearch: 20000,
          addFabPadding: true,
          gridViewColumnCalculator: patreonCustomColumnCount,
        ),
      ),
    );
  }
}
