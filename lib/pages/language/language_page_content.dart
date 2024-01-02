import 'package:flutter/material.dart';

import './translations_per_language_custom_chart.dart';
import '../../components/common/content_horizontal_spacing.dart';
import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../contracts/enum/locale_key.dart';
import '../../integration/dependency_injection_base.dart';

class LanguagePageContent extends StatelessWidget {
  final int numberOfLanguagesToShow;
  final List<Widget>? additionalButtons;
  const LanguagePageContent(
      {Key? key, this.additionalButtons, this.numberOfLanguagesToShow = 10})
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
    widgets.add(TranslationsPerLanguageCustomChart(
      numberOfLanguagesToShow: numberOfLanguagesToShow,
    ));
    if (additionalButtons != null) widgets.addAll(additionalButtons!);

    return ContentHorizontalSpacing(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(12),
        children: widgets,
      ),
    );
  }
}
