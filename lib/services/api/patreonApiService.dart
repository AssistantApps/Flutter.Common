import 'dart:convert';

import '../../constants/ApiUrls.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import './interface/IPatreonApiService.dart';

class PatreonApiService extends BaseApiService implements IPatreonApiService {
  PatreonApiService() : super(getEnv().assistantAppsApiUrl);

  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    try {
      final response = await this.apiGet(ApiUrls.patreon);
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
