import 'dart:convert';

import '../../constants/ApiUrls.dart';
import '../../contracts/enum/assistantAppType.dart';
import '../../contracts/generated/steamBranchesViewModel.dart';
import 'package:enum_to_string/enum_to_string.dart';

import '../../contracts/generated/steamNewsItemViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';

import '../BaseApiService.dart';
import 'interface/IsteamApiService.dart';

class SteamApiService extends BaseApiService implements ISteamApiService {
  SteamApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<List<SteamNewsItemViewModel>>> getSteamNews(
      AssistantAppType appType) async {
    try {
      String url = ApiUrls.steamNews + EnumToString.convertToString(appType);
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<List<SteamNewsItemViewModel>>(
            false, List.empty(growable: true), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var news =
          newsList.map((r) => SteamNewsItemViewModel.fromJson(r)).toList();
      return ResultWithValue(true, news, '');
    } catch (exception) {
      getLog().e("getSteamNews Api Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItemViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<List<SteamBranchesViewModel>>> getSteamBranches(
      AssistantAppType appType) async {
    try {
      String url =
          ApiUrls.steamBranches + EnumToString.convertToString(appType);
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return ResultWithValue<List<SteamBranchesViewModel>>(
            false, List.empty(growable: true), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var news =
          newsList.map((r) => SteamBranchesViewModel.fromJson(r)).toList();
      return ResultWithValue(true, news, '');
    } catch (exception) {
      getLog().e("getSteamNews Api Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamBranchesViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
