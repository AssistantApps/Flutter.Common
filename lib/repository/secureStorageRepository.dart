import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../contracts/results/result.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import 'interface/ILocalStorageRepository.dart';

class SecureStorageRepository implements ILocalStorageRepository {
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      await _storage.write(key: key, value: stateString);
      return Result(true, '');
    } catch (exception) {
      getLog().e('saveToStorage. ' + exception.toString());
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<String>> loadStringFromStorage(String key) async {
    try {
      String? stateString = await _storage.read(key: key);
      if (stateString == null) {
        return ResultWithValue<String>(false, '', 'StateString is null');
      }
      return ResultWithValue<String>(true, stateString, '');
    } catch (exception) {
      getLog().e('_loadStringFromStorageCommon. ' + exception.toString());
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }
}
