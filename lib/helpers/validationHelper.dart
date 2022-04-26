import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

OutlineInputBorder getTextFieldValidationBorderColour(
    BuildContext context, List<LocaleKey> errorLocales, bool showValidation) {
  bool isValid = errorLocales.length > 0 && !showValidation;
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
    border: OutlineInputBorder(),
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
