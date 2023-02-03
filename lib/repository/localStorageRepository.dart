import 'package:shared_preferences/shared_preferences.dart';

import '../contracts/results/result.dart';
import '../contracts/results/result_with_value.dart';
import '../integration/dependencyInjection.dart';
import './interface/ILocalStorageRepository.dart';

class LocalStorageRepository implements ILocalStorageRepository {
  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, stateString);
      return Result(true, '');
    } catch (exception) {
      getLog().e('saveToStorage. $exception');
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<String>> loadStringFromStorage(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? stateString = preferences.getString(key);
      if (stateString == null) {
        return ResultWithValue<String>(false, '', 'StateString is null');
      }
      return ResultWithValue<String>(true, stateString, '');
    } catch (exception) {
      getLog().e('_loadStringFromStorageCommon. $exception');
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }
}
