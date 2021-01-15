import 'package:flutter/material.dart';

import '../../components/fun/backgroundWrapper.dart';
import '../../components/searchableList.dart';
import '../../components/tilePresenters/patreonTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/ExternalUrls.dart';
import '../../contracts/enum/backgroundType.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../services/api/interface/IpatreonApiService.dart';
import '../../services/json/backupJsonService.dart';

class PatronListPage extends StatelessWidget {
  final String joinPatreon;
  final IPatreonApiService patreonApiService;
  final Widget Function(BuildContext) fullPageLoading;
  final String noItems;
  final String failedLatestDisplayingOld;
  PatronListPage(
    this.joinPatreon,
    this.patreonApiService,
    this.fullPageLoading, {
    this.noItems,
    this.failedLatestDisplayingOld,
  });

  Future<ResultWithValue<List<PatreonViewModel>>> wrapPatronsListCall(
    BuildContext context,
    Future<ResultWithValue<List<PatreonViewModel>>> Function() getPatrons,
  ) async {
    ResultWithValue<List<PatreonViewModel>> patronsResult = await getPatrons();
    if (!patronsResult.isSuccess) return patronsResult;

    List<PatreonViewModel> list = List<PatreonViewModel>();
    list.addAll(patronsResult.value);
    list.add(PatreonViewModel(
      name: joinPatreon,
      imageUrl: AppImage.onlinePatreonIcon,
      url: ExternalUrls.patreon,
    ));

    return ResultWithValue<List<PatreonViewModel>>(true, list, '');
  }

  @override
  Widget build(BuildContext context) {
    var apiFunc = () => this.patreonApiService.getPatrons();
    var backupFunc = () => BackupJsonService().getPatrons(context);
    return BackgroundWrapper(
      backgroundType: BackgroundType.Patreon,
      body: SearchableList<PatreonViewModel>(
        () => wrapPatronsListCall(context, apiFunc),
        patronTilePresenter,
        (_, __) => false,
        fullPageLoading,
        backupListGetter: () => wrapPatronsListCall(context, backupFunc),
        backupListWarningMessage: failedLatestDisplayingOld,
        noItems: noItems,
        minListForSearch: 20000,
      ),
    );
  }
}
