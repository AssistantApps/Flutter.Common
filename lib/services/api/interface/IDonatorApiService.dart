import '../../../contracts/generated/donation_view_model.dart';
import '../../../contracts/results/pagination_result_with_value.dart';

class IDonatorApiService {
  //
  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
      {int page = 1}) async {
    return PaginationResultWithValue<List<DonationViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }
}
