import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/misc/storageWithExpiry.dart';
import '../../repository/interface/ILocalStorageRepository.dart';
import './interface/ILocalStorageService.dart';

class LocalStorageService implements ILocalStorageService {
  late ILocalStorageRepository _localRepo;

  LocalStorageService(this._localRepo);

  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      await _localRepo.saveToStorage(key, stateString);
      return Result(true, '');
    } catch (exception) {
      getLog().e('saveToStorage. ' + exception.toString());
      return Result(false, exception.toString());
    }
  }

  @override
  Future<Result> saveToStorageWithExpiry(
      String key, String stateString, DateTime date) async {
    return await saveToStorage(
      key,
      StorageWithExpiry(data: stateString, expiryDateTime: date).toRawJson(),
    );
  }

  @override
  Future<ResultWithValue<String>> loadStringFromStorage(String key) =>
      _localRepo.loadStringFromStorage(key);

  @override
  Future<ResultWithValue<Map<String, dynamic>>> loadFromStorage(
      String key) async {
    ResultWithValue<String> stringFromStorageResult =
        await loadStringFromStorage(key);
    if (stringFromStorageResult.hasFailed)
      return ResultWithValue<Map<String, dynamic>>(
        stringFromStorageResult.isSuccess,
        Map<String, dynamic>(),
        stringFromStorageResult.toString(),
      );
    String stateString = stringFromStorageResult.value;
    try {
      Map<String, dynamic> stateMap =
          json.decode(stateString) as Map<String, dynamic>;
      return ResultWithValue<Map<String, dynamic>>(true, stateMap, '');
    } catch (exception) {
      getLog().e('loadFromStorage. ' + exception.toString());
      return ResultWithValue<Map<String, dynamic>>(
          false, Map<String, dynamic>(), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<String>> loadStringFromStorageCheckExpiry(
      String key) async {
    ResultWithValue<String> stateStringResult =
        await _localRepo.loadStringFromStorage(key);
    if (stateStringResult.hasFailed) {
      return stateStringResult;
    }

    StorageWithExpiry storageWithExpiry;
    try {
      storageWithExpiry =
          StorageWithExpiry.fromRawJson(stateStringResult.value);
    } catch (exception) {
      getLog().e('loadFromStorage' + exception.toString());
      return ResultWithValue<String>(false, '', exception.toString());
    }

    if (storageWithExpiry.expiryDateTime.isBefore(DateTime.now())) {
      return ResultWithValue<String>(false, '', '');
    }
    return ResultWithValue<String>(true, storageWithExpiry.data, '');
  }
}
