// import '../integration/dependency_injection.dart';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

List<LocaleKey> noValidator() => List.empty(growable: true);

List<LocaleKey> nameValidator(String name,
    {int minLength = 1, int maxLength = 100}) {
  List<LocaleKey> errors = List.empty(growable: true);
  if (name.length < minLength) {
    errors.add(LocaleKey.inputTooShort);
  }
  if (name.length > maxLength) {
    errors.add(LocaleKey.inputTooLong);
  }
  return errors;
}

List<LocaleKey> emailValidator(String email) {
  String regexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  List<LocaleKey> errors = List.empty(growable: true);
  bool emailValid = RegExp(regexPattern).hasMatch(email);
  if (emailValid == false) errors.add(LocaleKey.emailNotValid);
  return errors;
}

List<LocaleKey> numberValidator(String numberString,
    {int min = 1, int max = 9999}) {
  List<LocaleKey> errors = List.empty(growable: true);
  int number = int.tryParse(numberString) ?? 0;
  if (number < min) {
    errors.add(LocaleKey.inputTooLow);
  }
  if (number > max) {
    errors.add(LocaleKey.inputTooHigh);
  }
  return errors;
}
