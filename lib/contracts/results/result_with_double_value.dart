import './result_with_value.dart';

class ResultWithDoubleValue<T, K> extends ResultWithValue<T> {
  K secondValue;
  ResultWithDoubleValue(
      bool isSuccess, T value, this.secondValue, String errorMessage)
      : super(isSuccess, value, errorMessage);
}
