import './enum/localeKey.dart';

class LocalizationMap {
  LocaleKey name;
  String code;
  String countryCode;
  int serverSideId;

  LocalizationMap(this.name, this.code, this.countryCode, this.serverSideId);
}
