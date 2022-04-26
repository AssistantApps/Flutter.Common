import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';

Widget languageTilePresenter(
    BuildContext context, String name, String countryCode,
    {LocaleKey? trailingDisplay, int? percentageComplete, Function()? onTap}) {
  return ListTile(
    leading: SizedBox(
      child: Image.asset('icons/flags/png/$countryCode.png',
          package: 'country_icons'),
      width: 50,
      height: 50,
    ),
    title: Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: getTrailingWidget(trailingDisplay, percentageComplete),
    onTap: () {
      if (onTap != null) onTap();
    },
  );
}

Widget? getTrailingWidget(LocaleKey? trailingDisplay, int? percentageComplete) {
  String textToDisp = '';
  if (trailingDisplay != null) {
    textToDisp = getTranslations().fromKey(trailingDisplay);
  } else if (percentageComplete != null) {
    String percentTemplate = getTranslations().fromKey(LocaleKey.percentage);
    textToDisp = percentTemplate.replaceAll(
      '{0}',
      percentageComplete.toString(),
    );
  }

  if (textToDisp.length < 1) return null;

  return Text(
    textToDisp,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.end,
  );
}
