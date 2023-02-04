import 'dart:convert';

import '../../constants/api_urls.dart';
import '../../contracts/generated/patreon_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../integration/dependency_injection.dart';
import '../base_api_service.dart';
import './interface/i_patreon_api_service.dart';

class PatreonApiService extends BaseApiService implements IPatreonApiService {
  PatreonApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    try {
      final response = await apiGet(ApiUrls.patreon);
      if (response.hasFailed) {
        return ResultWithValue<List<PatreonViewModel>>(
            false, List.empty(growable: true), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      List<PatreonViewModel> releases =
          newsList.map((r) => PatreonViewModel.fromJson(r)).toList();
      return ResultWithValue(true, releases, '');
    } catch (exception) {
      getLog().e("getPatrons Api Exception: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
