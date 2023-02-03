import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/misc/storage_with_expiry.dart';
import '../../repository/interface/i_local_storage_repository.dart';
import './interface/ILocalStorageService.dart';

class LocalStorageService implements ILocalStorageService {
  final ILocalStorageRepository _localRepo;

  LocalStorageService(this._localRepo);

  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      await _localRepo.saveToStorage(key, stateString);
      return Result(true, '');
    } catch (exception) {
      getLog().e('saveToStorage. $exception');
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
    if (stringFromStorageResult.hasFailed) {
      getLog().e('stringFromStorageResult hasFailed');
      return ResultWithValue<Map<String, dynamic>>(
        stringFromStorageResult.isSuccess,
        <String, dynamic>{},
        stringFromStorageResult.errorMessage,
      );
    }
    String stateString = stringFromStorageResult.value;
    try {
      Map<String, dynamic> stateMap =
          json.decode(stateString) as Map<String, dynamic>;
      return ResultWithValue<Map<String, dynamic>>(true, stateMap, '');
    } catch (exception) {
      getLog().e('loadFromStorage. $exception');
      return ResultWithValue<Map<String, dynamic>>(
          false, <String, dynamic>{}, exception.toString());
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
      getLog().e('loadFromStorage$exception');
      return ResultWithValue<String>(false, '', exception.toString());
    }

    if (storageWithExpiry.expiryDateTime.isBefore(DateTime.now())) {
      return ResultWithValue<String>(false, '', '');
    }
    return ResultWithValue<String>(true, storageWithExpiry.data, '');
  }
}
