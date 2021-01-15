import '../../../contracts/generated/donationViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';

class IDonatorApiService {
  //
  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonators(
      {int page = 1}) async {
    return PaginationResultWithValue<List<DonationViewModel>>(
        false, List<DonationViewModel>(), 1, 0, '');
  }
}
