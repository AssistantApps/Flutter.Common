import 'package:flutter/material.dart';

import '../../components/tilePresenters/languageTilePresenter.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/localizationMap.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../integration/dependencyInjection.dart';
import '../dialog/optionsListPageDialog.dart';

class LanguageSelectionPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<LocalizationMap> supportedLanguageMaps =
        getLanguage().getLocalizationMaps();

    List<DropdownOption> options = supportedLanguageMaps
        .map((l) => DropdownOption(
              getTranslations().fromKey(l.name),
              value: l.code,
            ))
        .toList();
    options.sort((a, b) => a.title.compareTo(b.title));

    return OptionsListPageDialog(
      getTranslations().fromKey(LocaleKey.appLanguage),
      options,
      minListForSearch: 25,
      customPresenter: (
        BuildContext innerC,
        DropdownOption opt,
        int index, {
        void Function()? onTap,
      }) {
        LocalizationMap supportedLang =
            supportedLanguageMaps.firstWhere((sl) => sl.code == opt.value);
        return languageTilePresenter(
          innerC,
          opt.title,
          supportedLang.countryCode,
          onTap: () => Navigator.of(context).pop(opt.value),
        );
      },
    );
  }
}
