import '../../../contracts/generated/guide/guide_search_result_view_model.dart';
import '../../../contracts/generated/guide/add_guide_view_model.dart';
import '../../../contracts/generated/guide/guide_content_view_model.dart';
import '../../../contracts/generated/guide/guide_search_view_model.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/result.dart';
import '../../../contracts/results/resultWithValue.dart';

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
