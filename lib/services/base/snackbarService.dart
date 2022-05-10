import 'package:flutter/material.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/ISnackbarService.dart';

class SnackbarService implements ISnackbarService {
  late SweetSheet _sweetSheet;
  SnackbarService() {
    _sweetSheet = SweetSheet();
  }

  void showSnackbar(
    context,
    LocaleKey lang, {
    String? description,
    Duration? duration,
    void Function()? onPositive,
    String? onPositiveText,
    IconData? onPositiveIcon,
    void Function()? onNegative,
  }) {
    _sweetSheet.show(
      context: context,
      title: Text(getTranslations().fromKey(lang)),
      description: (description == null) ? Text('') : Text(description),
      color: SweetSheetColor.SUCCESS,
      isDismissible: true,
      positive: (onPositiveText != null)
          ? SweetSheetAction(
              onPressed: onPositive ?? () {},
              title: onPositiveText,
              icon: onPositiveIcon,
            )
          : SweetSheetAction(
              onPressed: () {},
              title: '',
            ),
      negative: SweetSheetAction(
        onPressed: onNegative ?? () => getNavigation().pop(context),
        title: getTranslations().fromKey(LocaleKey.close),
      ),
    );
  }
}
