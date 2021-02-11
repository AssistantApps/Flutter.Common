import '../../../contracts/generated/donationViewModel.dart';
import '../../../contracts/generated/patreonViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/resultWithValue.dart';

class IBackupJsonService {
  //
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons(context) async {
    return ResultWithValue<List<PatreonViewModel>>(
        false, List.empty(growable: true), '');
  }

  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonations(
      context,
      {int page = 1,
      int pageSize = 20}) async {
    return PaginationResultWithValue<List<DonationViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }
}
