import '../../constants/ApiUrls.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import 'interface/IDonatorApiService.dart';

class AppsApiService extends BaseApiService implements IDonatorApiService {
  AppsApiService() : super(getEnv().assistantAppsApiUrl);

  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
      {int page = 1}) async {
    String url = '${ApiUrls.donator}?page=$page';
    try {
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return PaginationResultWithValue<List<DonationViewModel>>(
            false, List.empty(growable: true), 1, 0, response.errorMessage);
      }
      PaginationResultWithValue<List<DonationViewModel>> paginationResult =
          PaginationResultWithValueMapper()
              .fromRawJson<List<DonationViewModel>>(response.value,
                  (List valueDyn) {
        return valueDyn.map((r) => DonationViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      getLog().e("donators Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<DonationViewModel>>(
          false, List.empty(growable: true), 1, 0, exception.toString());
    }
  }
}
