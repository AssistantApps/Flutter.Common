import '../../../contracts/generated/donation_view_model.dart';
import '../../../contracts/generated/patreon_view_model.dart';
import '../../../contracts/results/pagination_result_with_value.dart';
import '../../../contracts/results/result_with_value.dart';

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
