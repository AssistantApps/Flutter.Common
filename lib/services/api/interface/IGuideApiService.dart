import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../../contracts/generated/guide/addGuideViewModel.dart';
import '../../../contracts/generated/guide/guideContentViewModel.dart';
import '../../../contracts/generated/guide/guideSearchViewModel.dart';

class IGuideApiService {
  Future<PaginationResultWithValue<List<GuideSearchResultViewModel>>>
      getAllGuides(GuideSearchViewModel searchOptions) async {
    return PaginationResultWithValue<List<GuideSearchResultViewModel>>(
        false, List.empty(), 1, 0, '');
  }

  Future<Result> addGuide(AddGuideViewModel newGuide) async {
    return Result(false, 'Not Implemented');
  }

  Future<ResultWithValue<GuideContentViewModel>> getGuideContent(
      String guid) async {
    return ResultWithValue<GuideContentViewModel>(
        false, GuideContentViewModel.fromRawJson('{}'), 'Not Implemented');
  }
}
