import 'package:flutter/material.dart';

import '../contracts/enum/locale_key.dart';
import '../integration/dependency_injection.dart';
import './string_helper.dart';

OutlineInputBorder getTextFieldValidationBorderColour(
    BuildContext context, List<LocaleKey> errorLocales, bool showValidation) {
  bool isValid = errorLocales.isNotEmpty && !showValidation;
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: isValid ? getTheme().getSecondaryColour(context) : Colors.red,
    ),
  );
}

InputDecoration getTextFieldDecoration(
  BuildContext context,
  LocaleKey locale,
  List<LocaleKey> Function()? validator,
  bool showValidation,
) {
  List<LocaleKey> errorLocales =
      (validator != null) ? validator() : List.empty();
  OutlineInputBorder errorBorder = getTextFieldValidationBorderColour(
    context,
    errorLocales,
    showValidation,
  );
  return InputDecoration(
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: getTheme().getPrimaryColour(context),
      ),
    ),
    focusedErrorBorder: errorBorder,
    errorBorder: errorBorder,
    labelText: getTranslations().fromKey(locale),
    errorMaxLines: 1,
    errorText: showValidation
        ? joinStringList(
            errorLocales.map((loc) => getTranslations().fromKey(loc)).toList(),
            ' & ')
        : null,
  );
}
