import 'package:flutter/material.dart';

import '../../components/fun/backgroundWrapper.dart';
import '../../components/list/searchableList.dart';
import '../../components/tilePresenters/patreonTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/ExternalUrls.dart';
import '../../contracts/enum/backgroundType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../../services/json/backupJsonService.dart';

class PatronListPageWidget extends StatelessWidget {
  Future<ResultWithValue<List<PatreonViewModel>>> wrapPatronsListCall(
    BuildContext context,
    Future<ResultWithValue<List<PatreonViewModel>>> Function() getPatrons,
  ) async {
    ResultWithValue<List<PatreonViewModel>> patronsResult = await getPatrons();
    if (!patronsResult.isSuccess) return patronsResult;

    List<PatreonViewModel> list = List<PatreonViewModel>();
    list.addAll(patronsResult.value);
    list.add(PatreonViewModel(
      name: Translations.fromKey(LocaleKey.joinPatreon),
      imageUrl: AppImage.onlinePatreonIcon,
      url: ExternalUrls.patreon,
    ));

    return ResultWithValue<List<PatreonViewModel>>(true, list, '');
  }

  @override
  Widget build(BuildContext context) {
    var apiFunc = () => getAssistantAppsPatreons().getPatrons();
    var backupFunc = () => BackupJsonService().getPatrons(context);
    return BackgroundWrapper(
      backgroundType: BackgroundType.Patreon,
      body: SearchableList<PatreonViewModel>(
        () => wrapPatronsListCall(context, apiFunc),
        patronTilePresenter,
        (_, __) => false,
        backupListGetter: () => wrapPatronsListCall(context, backupFunc),
        minListForSearch: 20000,
      ),
    );
  }
}
