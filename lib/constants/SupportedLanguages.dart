import '../contracts/enum/localeKey.dart';
import '../contracts/localizationMap.dart';

final englishLanguageMap = LocalizationMap(LocaleKey.english, 'en', 'gb', 3);

final List<LocalizationMap> supportedLanguageMaps = [
  englishLanguageMap,
  LocalizationMap(LocaleKey.dutch, 'nl', 'nl', 2),
  LocalizationMap(LocaleKey.french, 'fr', 'fr', 4),
  LocalizationMap(LocaleKey.german, 'de', 'de', 5),
  LocalizationMap(LocaleKey.italian, 'it', 'it', 6),
  LocalizationMap(LocaleKey.indonesian, 'id', 'id', 21),
  LocalizationMap(LocaleKey.brazilianPortuguese, 'pt-br', 'br', 1),
  LocalizationMap(LocaleKey.polish, 'pl', 'pl', 10),
  LocalizationMap(LocaleKey.portuguese, 'pt', 'pt', 11),
  LocalizationMap(LocaleKey.romanian, 'ro', 'ro', 22),
  LocalizationMap(LocaleKey.russian, 'ru', 'ru', 12),
  LocalizationMap(LocaleKey.spanish, 'es', 'es', 14),
  LocalizationMap(LocaleKey.czech, 'cs', 'cz', 16),
  LocalizationMap(LocaleKey.turkish, 'tr', 'tr', 17),
  LocalizationMap(LocaleKey.hungarian, 'hu', 'hu', 18),
  LocalizationMap(LocaleKey.simplifiedChinese, 'zh-hans', 'cn', 13),
  LocalizationMap(LocaleKey.traditionalChinese, 'zh-hant', 'cn', 15),
  LocalizationMap(LocaleKey.afrikaans, 'af', 'za', 19),
  // LocalizationMap(LocaleKey.arabic, 'ar', 'ar', 20),
];

final List<LocaleKey> supportedLanguages =
    supportedLanguageMaps.map((l) => l.name).toList();
final List<String> supportedLanguagesCodes =
    supportedLanguageMaps.map((l) => l.code).toList();
