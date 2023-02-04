import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class ILocalStorageRepository {
  Future<Result> saveToStorage(String key, String stateJson) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<String>> loadStringFromStorage(String key) async =>
      ResultWithValue<String>(false, '', 'Not Implemented');
}
