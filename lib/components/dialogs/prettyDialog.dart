import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:giffy_dialog/giffy_dialog.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import '../common/image.dart';

void prettyDialog(
  BuildContext context,
  String appImage,
  String title,
  String description, {
  String? imagePackage,
  bool onlyCancelButton = false,
  Function()? onCancel,
  Function()? onSuccess,
}) {
  prettyDialogWithWidget(
    context,
    localImage(appImage, imagePackage: imagePackage),
    title,
    description,
    onlyCancelButton: onlyCancelButton,
    onCancel: onCancel,
    onSuccess: onSuccess,
  );
}

void prettyDialogWithWidget(
  BuildContext context,
  Widget imageWidget,
  String title,
  String description, {
  bool onlyCancelButton = false,
  Function()? onCancel,
  Function()? onSuccess,
}) {
  showDialog(
    context: context,
    builder: (_) => NetworkGiffyDialog(
      image: imageWidget,
      title: title.isNotEmpty
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            )
          : null,
      description: Text(description, textAlign: TextAlign.center),
      entryAnimation: EntryAnimation.TOP,
      buttonOkText: Text(getTranslations().fromKey(LocaleKey.ok)),
      buttonOkColor: getTheme().getSecondaryColour(context),
      onOkButtonPressed: () {
        if (onSuccess != null) {
          onSuccess();
        } else {
          Navigator.pop(context);
        }
      },
      onlyCancelButton: onlyCancelButton,
      buttonCancelText: Text(onlyCancelButton
          ? getTranslations().fromKey(LocaleKey.ok)
          : getTranslations().fromKey(LocaleKey.cancel)),
      onCancelButtonPressed: onCancel,
    ),
  );
}
