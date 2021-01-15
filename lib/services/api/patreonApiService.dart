import 'dart:convert';

import '../../constants/ApiUrls.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../BaseApiService.dart';
import 'interface/IpatreonApiService.dart';

class PatreonApiService extends BaseApiService implements IPatreonApiService {
  final String assistantAppsAppGuid;
  PatreonApiService(String baseUrl, this.assistantAppsAppGuid,
      {void Function(String) debugLogger, void Function(String) errorLogger})
      : super(baseUrl, debugLogger: debugLogger, errorLogger: errorLogger);

  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    try {
      final response = await this.apiGet(ApiUrls.patreon);
      if (response.hasFailed) {
        return ResultWithValue<List<PatreonViewModel>>(
            false, List<PatreonViewModel>(), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var releases = newsList.map((r) => PatreonViewModel.fromJson(r)).toList();
      return ResultWithValue(true, releases, '');
    } catch (exception) {
      this.error("getPatrons Api Exception: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List<PatreonViewModel>(), exception.toString());
    }
  }
}
