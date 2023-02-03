import '../../constants/api_urls.dart';
import '../../contracts/enum/platform_type.dart';
import '../../contracts/generated/version_search_view_model.dart';
import '../../contracts/generated/version_view_model.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import './interface/IVersionApiService.dart';

class VersionApiService extends BaseApiService implements IVersionApiService {
  VersionApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<VersionViewModel>> getLatest(
    List<PlatformType> platforms,
  ) async {
    if (platforms.isEmpty) {
      return ResultWithValue<VersionViewModel>(
          false, VersionViewModel.empty(), 'No Platforms specified');
    }

    List<String?> queryParams =
        platforms.map((p) => platformTypeToIntValues.map[p]).toList();
    String queryPath = '';
    for (var queryParam in queryParams) {
      if (queryParam == null || queryParam.isEmpty) continue;
      if (queryPath.isNotEmpty) {
        queryPath = '$queryPath&';
      }
      queryPath = '${queryPath}platforms=$queryParam';
    }
    String url =
        "${ApiUrls.appVersion}/${getEnv().assistantAppsAppGuid}?$queryPath";
    try {
      final response = await apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<VersionViewModel>(
            false, VersionViewModel.empty(), response.errorMessage);
      }
      return ResultWithValue(
          true, VersionViewModel.fromRawJson(response.value), '');
    } catch (exception) {
      getLog().e("getLatest Api Exception: ${exception.toString()}");
      return ResultWithValue<VersionViewModel>(
          false, VersionViewModel.empty(), exception.toString());
    }
  }

  @override
  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
    String langCode,
    List<PlatformType> platforms, {
    int page = 1,
  }) async {
    VersionSearchViewModel body = VersionSearchViewModel(
      appGuid: getEnv().assistantAppsAppGuid,
      languageCode: langCode,
      platforms: platforms,
      page: page,
    );
    try {
      final response = await apiPost(
        ApiUrls.versionSearch,
        body.toRawJson(),
      );
      if (response.hasFailed) {
        return PaginationResultWithValue<List<VersionViewModel>>(
            false, List.empty(growable: true), 0, 0, response.errorMessage);
      }
      PaginationResultWithValue<List<VersionViewModel>> paginationResult =
          PaginationResultWithValueMapper().fromRawJson<List<VersionViewModel>>(
              response.value, (List valueDyn) {
        return valueDyn.map((r) => VersionViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      getLog().e("getHistory Api Exception: ${exception.toString()}");
      List<VersionViewModel> result = List.empty(growable: true);
      return PaginationResultWithValue<List<VersionViewModel>>(
          false, result, 0, 0, exception.toString());
    }
  }
}
