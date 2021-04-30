import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/ISnackbarService.dart';

class SnackbarService implements ISnackbarService {
  static const defaultDismissDirection = FlushbarDismissDirection.VERTICAL;

  void showSnackbar(context, LocaleKey lang,
      {Duration duration, TextButton action}) {
    var textString = Text(
      getTranslations().fromKey(lang),
      style: TextStyle(color: Colors.black),
    );
    Flushbar(
      messageText: textString,
      duration: duration ?? Duration(seconds: 5),
      backgroundColor: getTheme().getSecondaryColour(context),
      isDismissible: true,
      dismissDirection: defaultDismissDirection,
      mainButton: action,
    )..show(context);
  }
}
