import './result.dart';

class ResultWithValue<T> extends Result {
  T value;
  ResultWithValue(bool isSuccess, this.value, String errorMessage)
      : super(isSuccess, errorMessage);
}
