import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import './interface/IGuideApiService.dart';
import '../../constants/ApiUrls.dart';
import '../../contracts/generated/guide/addGuideViewModel.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/generated/guide/guideSearchViewModel.dart';
import '../../integration/dependencyInjection.dart';

class GuideApiService extends BaseApiService implements IGuideApiService {
  GuideApiService() : super(getEnv().assistantAppsApiUrl);

  Future<PaginationResultWithValue<List<GuideSearchResultViewModel>>>
      getAllGuides(GuideSearchViewModel searchOptions) async {
    try {
      final response = await this.apiPost(
        ApiUrls.guideSearch,
        searchOptions.toRawJson(),
      );
      if (response.hasFailed) {
        return PaginationResultWithValue<List<GuideSearchResultViewModel>>(
            false, List.empty(), 0, 0, response.errorMessage);
      }
      var paginationResult = PaginationResultWithValueMapper()
          .fromRawJson<List<GuideSearchResultViewModel>>(
        response.value,
        (List<dynamic> valueDyn) {
          return valueDyn
              .map((r) => GuideSearchResultViewModel.fromJson(r))
              .toList();
        },
      );

      return paginationResult;
    } catch (exception) {
      getLog()
          .e("GuideApiService-searchGuides Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<GuideSearchResultViewModel>>(
          false, List.empty(), 0, 0, exception.toString());
    }
  }

  @override
  Future<Result> addGuide(AddGuideViewModel newGuide) async {
    try {
      final response = await this.apiPost(
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
    try {
      var url = "${ApiUrls.guideContent}/$guid";
      ResultWithValue<String> response = await this.apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<GuideContentViewModel>(
          false,
          GuideContentViewModel.fromJson(Map<String, dynamic>()),
          response.errorMessage,
        );
      }
      GuideContentViewModel guideContent =
          GuideContentViewModel.fromRawJson(response.value);
      return ResultWithValue(true, guideContent, '');
    } catch (exception) {
      getLog().e(
          "GuideApiService-getGuideContent Exception: ${exception.toString()}");
      return ResultWithValue<GuideContentViewModel>(
        false,
        GuideContentViewModel.fromJson(Map<String, dynamic>()),
        exception.toString(),
      );
    }
  }
}
