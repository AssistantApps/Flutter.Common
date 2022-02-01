import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/ISnackbarService.dart';

class SnackbarService implements ISnackbarService {
  SweetSheet _sweetSheet;
  SnackbarService() {
    _sweetSheet = SweetSheet();
  }

  void showSnackbar(
    context,
    LocaleKey lang, {
    String description,
    Duration duration,
    void Function() onPositive,
    String onPositiveText,
  }) {
    _sweetSheet.show(
      context: context,
      title: Text(getTranslations().fromKey(lang)),
      description: (description == null) ? null : Text(description),
      color: SweetSheetColor.SUCCESS,
      isDismissible: true,
      positive: (onPositiveText != null)
          ? SweetSheetAction(
              onPressed: onPositive,
              title: onPositiveText,
            )
          : null,
      negative: SweetSheetAction(
        onPressed: () => getNavigation().pop(context),
        title: getTranslations().fromKey(LocaleKey.close),
      ),
    );
  }
}
