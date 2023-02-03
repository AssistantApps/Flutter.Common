import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import './translations_per_language_custom_chart.dart';

class LanguagePageContent extends StatelessWidget {
  final List<Widget>? additionalButtons;
  const LanguagePageContent({Key? key, this.additionalButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      GenericItemDescription(
        getTranslations().fromKey(LocaleKey.languageContent),
      ),
      const EmptySpace3x(),
    ];
    widgets.add(GenericItemText(
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
