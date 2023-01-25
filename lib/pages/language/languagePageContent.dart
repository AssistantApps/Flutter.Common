import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import './translationsPerLanguageCustomChart.dart';

class LanguagePageContent extends StatelessWidget {
  final List<Widget>? additionalButtons;
  const LanguagePageContent({Key? key, this.additionalButtons})
      : super(key: key);

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
    widgets.add(const TranslationsPerLanguageCustomChart());
    if (additionalButtons != null) widgets.addAll(additionalButtons!);

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      children: widgets,
    );
  }
}
