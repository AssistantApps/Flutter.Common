import 'dart:convert';

import '../../helpers/jsonHelper.dart';

import './resultWithValue.dart';

class PaginationResultWithValue<T> extends ResultWithValue<T> {
  int currentPage;
  int totalPages;
  PaginationResultWithValue(bool isSuccess, T value, this.currentPage,
      this.totalPages, String errorMessage)
      : super(isSuccess, value, errorMessage) {}
}

class PaginationResultWithValueMapper {
  PaginationResultWithValue<T> fromRawJson<T>(
          String str, T Function(List<dynamic>) mapper) =>
      fromJson(json.decode(str), mapper);

  PaginationResultWithValue<T> fromJson<T>(
      Map<String, dynamic> json, T Function(List<dynamic>) mapper) {
    return PaginationResultWithValue<T>(
      readBoolSafe(json, 'isSuccess'),
      mapper(json['value'] as List),
      readIntSafe(json, 'currentPage'),
      readIntSafe(json, 'totalPages'),
      readStringSafe(json, 'errorMessage'),
    );
  }
}
