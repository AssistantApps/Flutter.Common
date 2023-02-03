import 'dart:convert';

import '../../contracts/generated/donation_view_model.dart';
import '../../contracts/generated/patreon_view_model.dart';
import '../../contracts/results/pagination_result_with_value.dart';
import '../../contracts/results/result_with_value.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseJsonService.dart';
import './interface/IbackupJsonService.dart';

class BackupJsonService extends BaseJsonService implements IBackupJsonService {
  @override
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons(context) async {
    try {
      dynamic jsonString =
          await getJsonFromAssets(context, 'data/patronsBackup');
      List responseJson = json.decode(jsonString);
      List<PatreonViewModel> backupItems =
          responseJson.map((m) => PatreonViewModel.fromJson(m)).toList();

      return ResultWithValue<List<PatreonViewModel>>(true, backupItems, '');
    } catch (exception) {
      getLog().e("BackupJsonService getPatrons() Ex: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  @override
  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonations(
      context,
      {int page = 1,
      int pageSize = 20}) async {
    try {
      dynamic jsonString =
          await getJsonFromAssets(context, 'data/donationsBackup');
      List responseJson = json.decode(jsonString);
      List<DonationViewModel> backupItems =
          responseJson.map((m) => DonationViewModel.fromJson(m)).toList();

      int totalPages = backupItems.length ~/ pageSize;
      List<DonationViewModel> filteredItems = backupItems
          .skip((page - 1) * pageSize) //
          .take(pageSize) //
          .toList();

      return PaginationResultWithValue<List<DonationViewModel>>(
          true, filteredItems, page, totalPages, '');
    } catch (exception) {
      getLog()
          .e("BackupJsonService getDonations() Ex: ${exception.toString()}");
      return PaginationResultWithValue<List<DonationViewModel>>(
          false, List.empty(growable: true), 1, 0, exception.toString());
    }
  }
}
