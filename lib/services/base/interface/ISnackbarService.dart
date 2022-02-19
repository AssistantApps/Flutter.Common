import '../../../contracts/enum/localeKey.dart';

class ISnackbarService {
  void showSnackbar(
    context,
    LocaleKey lang, {
    String? description,
    Duration? duration,
    void Function()? onPositive,
    String? onPositiveText,
  }) {}
}
