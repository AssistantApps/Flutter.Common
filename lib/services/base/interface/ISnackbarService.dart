import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';

class ISnackbarService {
  void showSnackbar(
    BuildContext context,
    LocaleKey lang, {
    String? description,
    Duration? duration,
    void Function()? onPositive,
    String? onPositiveText,
    IconData? onPositiveIcon,
    void Function()? onNegative,
  }) {}
}
