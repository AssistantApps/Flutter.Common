import '../../constants/ApiUrls.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionSearchViewModel.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../BaseApiService.dart';
import 'interface/IversionApiService.dart';

class VersionApiService extends BaseApiService implements IVersionApiService {
  final String assistantAppsAppGuid;
  VersionApiService(String baseUrl, this.assistantAppsAppGuid,
      {void Function(String) debugLogger, void Function(String) errorLogger})
      : super(baseUrl, debugLogger: debugLogger, errorLogger: errorLogger);

  Future<ResultWithValue<VersionViewModel>> getLatest(
      List<PlatformType> platforms) async {
    var url = "${ApiUrls.appVersion}/$assistantAppsAppGuid";
    try {
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<VersionViewModel>(
            false, VersionViewModel(), response.errorMessage);
      }
      return ResultWithValue(
          true, VersionViewModel.fromRawJson(response.value), '');
    } catch (exception) {
      this.error("getLatest Api Exception: ${exception.toString()}");
      return ResultWithValue<VersionViewModel>(
          false, VersionViewModel(), exception.toString());
    }
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
      String langCode, List<PlatformType> platforms,
      {int page = 1}) async {
    VersionSearchViewModel body = VersionSearchViewModel(
      appGuid: this.assistantAppsAppGuid,
      languageCode: langCode,
      platforms: platforms,
      page: page,
    );
    try {
      final response =
          await this.apiPost(ApiUrls.versionSearch, body.toRawJson());
      if (response.hasFailed) {
        return PaginationResultWithValue<List<VersionViewModel>>(
            false, List<VersionViewModel>(), 0, 0, response.errorMessage);
      }
      var paginationResult = PaginationResultWithValueMapper()
          .fromRawJson<List<VersionViewModel>>(response.value, (List valueDyn) {
        return valueDyn.map((r) => VersionViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      this.error("getHistory Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<VersionViewModel>>(
          false, List<VersionViewModel>(), 0, 0, exception.toString());
    }
  }
}
