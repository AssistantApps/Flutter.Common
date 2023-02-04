import 'package:flutter/material.dart';

import '../../components/fun/background_wrapper.dart';
import '../../components/grid/searchable_grid.dart';
import '../../components/tilePresenters/patreon_tile_presenter.dart';
import '../../constants/app_image.dart';
import '../../constants/external_urls.dart';
import '../../contracts/enum/background_type.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/patreon_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/column_helper.dart';
import '../../integration/dependency_injection_api.dart';
import '../../integration/dependency_injection_base.dart';
import '../../services/json/backup_json_service.dart';

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
