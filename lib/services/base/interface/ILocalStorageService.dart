import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class ILocalStorageService {
  Future<Result> saveToStorage(String key, String stateJson) async =>
      Result(false, 'Not Implemented');

  Future<Result> saveToStorageWithExpiry(
          String key, String stateString, DateTime date) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<String>> loadStringFromStorage(String key) async =>
      ResultWithValue<String>(false, '', 'Not Implemented');

  Future<ResultWithValue<String>> loadStringFromStorageCheckExpiry(
          String key) async =>
      ResultWithValue<String>(false, '', 'Not Implemented');

  Future<ResultWithValue<Map<String, dynamic>>> loadFromStorage(
          String key) async =>
      ResultWithValue<Map<String, dynamic>>(
          false, Map<String, dynamic>(), 'Not Implemented');
}
