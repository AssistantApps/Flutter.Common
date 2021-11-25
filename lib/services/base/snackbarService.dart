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
    Duration duration,
    void Function() onPositive,
    String onPositiveText,
  }) {
    _sweetSheet.show(
      context: context,
      description: Text(getTranslations().fromKey(lang)),
      color: SweetSheetColor.SUCCESS,
      isDismissible: true,
      icon: Icons.cloud_download,
      positive: SweetSheetAction(
        onPressed: onPositive,
        title: onPositiveText,
      ),
      negative: SweetSheetAction(
        onPressed: () => getNavigation().pop(context),
        title: getTranslations().fromKey(LocaleKey.close),
      ),
    );
  }
}
