import './resultWithValue.dart';

class ResultWithDoubleValue<T, K> extends ResultWithValue<T> {
  late K secondValue;
  ResultWithDoubleValue(
      bool isSuccess, T value, K secondValue, String errorMessage)
      : super(isSuccess, value, errorMessage) {
    secondValue = secondValue;
  }
}
