import '../../../contracts/enum/platform_type.dart';
import '../../../contracts/generated/version_view_model.dart';
import '../../../contracts/results/pagination_result_with_value.dart';
import '../../../contracts/results/result_with_value.dart';

class IVersionApiService {
  Future<ResultWithValue<VersionViewModel>> getLatest(
      List<PlatformType> platforms) async {
    return ResultWithValue<VersionViewModel>(
        false, VersionViewModel.empty(), '');
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
      String langCode, List<PlatformType> platforms,
      {int page = 1}) async {
    return PaginationResultWithValue<List<VersionViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }
}
