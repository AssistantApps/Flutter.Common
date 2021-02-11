import '../../../contracts/generated/patreonViewModel.dart';
import '../../../contracts/results/resultWithValue.dart';

class IPatreonApiService {
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    return ResultWithValue<List<PatreonViewModel>>(
        false, List.empty(growable: true), '');
  }
}
