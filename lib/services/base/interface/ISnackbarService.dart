import '../../../contracts/enum/localeKey.dart';

class ISnackbarService {
  void showSnackbar(
    context,
    LocaleKey lang, {
    Duration duration,
    void Function() onPositive,
    String onPositiveText,
  }) {}
}
