import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import 'translationsPerLanguageCustomChart.dart';

class LanguagePageContent extends StatelessWidget {
  final List<Widget>? additionalButtons;
  LanguagePageContent({this.additionalButtons});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      genericItemDescription(
        getTranslations().fromKey(LocaleKey.languageContent),
      ),
      emptySpace3x(),
    ];
    widgets.add(genericItemText(
      getTranslations().fromKey(LocaleKey.translationPercentageComplete),
    ));
    widgets.add(TranslationsPerLanguageCustomChart());
    if (additionalButtons != null) widgets.addAll(additionalButtons!);

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      children: widgets,
    );
  }
}
