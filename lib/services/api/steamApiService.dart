import 'dart:convert';

import '../../constants/api_urls.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../contracts/generated/steam_branches_view_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

import '../../contracts/generated/steam_news_item_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../integration/dependency_injection.dart';

import '../BaseApiService.dart';
import './interface/ISteamApiService.dart';

class SteamApiService extends BaseApiService implements ISteamApiService {
  SteamApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<List<SteamNewsItemViewModel>>> getSteamNews(
      AssistantAppType appType) async {
    try {
      String url = ApiUrls.steamNews + EnumToString.convertToString(appType);
      final response = await apiGet(url);
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
      final response = await apiGet(url);
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
