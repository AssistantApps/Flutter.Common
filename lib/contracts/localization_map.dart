import './enum/locale_key.dart';

class LocalizationMap {
  LocaleKey name;
  String code;
  String countryCode;
  int? percentageComplete;

  LocalizationMap(
    this.name,
    this.code,
    this.countryCode, {
    this.percentageComplete,
  });
}
