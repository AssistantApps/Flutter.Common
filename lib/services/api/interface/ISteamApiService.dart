import '../../../contracts/enum/assistant_app_type.dart';
import '../../../contracts/generated/steam_branches_view_model.dart';
import '../../../contracts/generated/steam_news_item_view_model.dart';
import '../../../contracts/results/resultWithValue.dart';

class ISteamApiService {
  Future<ResultWithValue<List<SteamNewsItemViewModel>>> getSteamNews(
      AssistantAppType appType) async {
    return ResultWithValue<List<SteamNewsItemViewModel>>(
        false, List.empty(growable: true), '');
  }

  Future<ResultWithValue<List<SteamBranchesViewModel>>> getSteamBranches(
      AssistantAppType appType) async {
    return ResultWithValue<List<SteamBranchesViewModel>>(
        false, List.empty(growable: true), '');
  }
}
