import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/constants/api_urls.dart';

import '../mock/data/guide_content_results.dart';
import '../mock/data/guide_search_results.dart';

class GuideApiService extends BaseApiService implements IGuideApiService {
  GuideApiService() : super('');

  @override
  Future<PaginationResultWithValue<List<GuideSearchResultViewModel>>>
      getAllGuides(GuideSearchViewModel searchOptions) async {
    List<GuideSearchResultViewModel> guides = List.empty(growable: true);
    guides.add(sampleGuide1());
    guides.add(sampleGuide2());
    // if ((searchOptions.name ?? '').contains('1')) {
    //   guides.add(sampleGuide1());
    // }
    return Future.value(
      PaginationResultWithValue<List<GuideSearchResultViewModel>>(
          true, guides, 1, 1, ''),
    );
  }

  @override
  Future<Result> addGuide(AddGuideViewModel newGuide) async {
    try {
      final response = await apiPost(
        ApiUrls.guideDetail,
        newGuide.toRawJson(),
      );
      if (response.hasFailed) {
        return Result(false, response.errorMessage);
      }

      return Result(true, '');
    } catch (exception) {
      getLog().e("GuideApiService-addGuide Exception: ${exception.toString()}");
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<GuideContentViewModel>> getGuideContent(
      String guid) async {
    GuideContentViewModel guide = sampleGuideContent2();
    if (guid == sampleGuideGuid1) guide = sampleGuideContent1();
    return ResultWithValue(true, guide, '');
  }
}
