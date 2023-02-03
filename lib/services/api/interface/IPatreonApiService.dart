import '../../../contracts/generated/patreon_view_model.dart';
import '../../../contracts/results/result_with_value.dart';

class IPatreonApiService {
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons() async {
    return ResultWithValue<List<PatreonViewModel>>(
        false, List.empty(growable: true), '');
  }
}
