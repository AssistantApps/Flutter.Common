import '../../../contracts/enum/platformType.dart';
import '../../../contracts/generated/versionViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/resultWithValue.dart';

class IVersionApiService {
  Future<ResultWithValue<VersionViewModel>> getLatest(
      List<PlatformType> platforms) async {
    return ResultWithValue<VersionViewModel>(false, VersionViewModel(), '');
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getHistory(
      String langCode, List<PlatformType> platforms,
      {int page = 1}) async {
    return PaginationResultWithValue<List<VersionViewModel>>(
        false, List<VersionViewModel>(), 1, 0, '');
  }
}
