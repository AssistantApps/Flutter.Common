import '../../constants/ApiUrls.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../BaseApiService.dart';
import 'interface/IdonatorApiService.dart';

class DonatorApiService extends BaseApiService implements IDonatorApiService {
  final String assistantAppsAppGuid;
  DonatorApiService(String baseUrl, this.assistantAppsAppGuid,
      {void Function(String) debugLogger, void Function(String) errorLogger})
      : super(baseUrl, debugLogger: debugLogger, errorLogger: errorLogger);

  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
      {int page = 1}) async {
    String url = '${ApiUrls.donator}?page=$page';
    try {
      final response = await this.apiGet(url);
      if (response.hasFailed) {
        return PaginationResultWithValue<List<DonationViewModel>>(
            false, List<DonationViewModel>(), 1, 0, response.errorMessage);
      }
      var paginationResult = PaginationResultWithValueMapper()
          .fromRawJson<List<DonationViewModel>>(response.value,
              (List valueDyn) {
        return valueDyn.map((r) => DonationViewModel.fromJson(r)).toList();
      });
      return paginationResult;
    } catch (exception) {
      this.error("donators Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<DonationViewModel>>(
          false, List<DonationViewModel>(), 1, 0, exception.toString());
    }
  }
}
