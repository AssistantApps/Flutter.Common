import './result.dart';

class ResultWithValue<T> extends Result {
  late T value;
  ResultWithValue(bool isSuccess, T value, String errorMessage)
      : super(isSuccess, errorMessage) {
    value = value;
  }
}
