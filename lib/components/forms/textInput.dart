import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../contracts/enum/localeKey.dart';
import '../../helpers/validationHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../adaptive/checkbox.dart';

var textEditingPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0);

Widget formTextInput(
  BuildContext context,
  TextEditingController textController,
  LocaleKey locale, {
  String? baseKey,
  int maxLines = 1,
  bool isMultiline = false,
  List<LocaleKey> Function()? validator,
  bool showValidation = false,
  required void Function(String text) onChange,
}) {
  return baseFormInput(
    context,
    textController,
    locale,
    baseKey: baseKey,
    maxLines: isMultiline ? null : maxLines,
    keyboardType: isMultiline ? TextInputType.multiline : null,
    validator: validator,
    showValidation: showValidation,
    onChange: onChange,
  );
}

Widget formNumberInput(
  BuildContext context,
  TextEditingController textController,
  LocaleKey locale, {
  String? baseKey,
  required List<LocaleKey> Function()? validator,
  bool showValidation = false,
  required void Function(String text) onChange,
}) {
  return baseFormInput(
    context,
    textController,
    locale,
    baseKey: baseKey,
    validator: validator,
    showValidation: showValidation,
    onChange: onChange,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
    ],
  );
}

Widget baseFormInput(
  BuildContext context,
  TextEditingController textController,
  LocaleKey locale, {
  String? baseKey,
  int? maxLines = 1,
  bool isMultiline = false,
  List<LocaleKey> Function()? validator,
  bool showValidation = false,
  required void Function(String text) onChange,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyboardType,
}) {
  return Padding(
    key: baseKey == null ? null : Key('$baseKey-padding'),
    padding: textEditingPadding,
    child: TextField(
      key: Key('$baseKey-textField'),
      controller: textController,
      decoration: getTextFieldDecoration(
        context,
        locale,
        validator,
        showValidation,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChange,
    ),
  );
}

Widget formBoolInput(
  BuildContext context,
  bool value,
  LocaleKey locale, {
  bool isMobile = false,
  required Function(bool newValue) onChange,
}) {
  return Padding(
    padding: textEditingPadding,
    child: GestureDetector(
      child: Row(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          adaptiveCheckbox(
            value: value,
            onChanged: onChange,
          ),
          Text(getTranslations().fromKey(locale)),
        ],
      ),
      onTap: () => onChange(!value),
    ),
  );
}
