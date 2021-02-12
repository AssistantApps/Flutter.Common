import '../../components/tilePresenters/languageTilePresenter.dart';

import '../dialog/optionsListPageDialog.dart';

import '../../assistantapps_flutter_common.dart';
import '../../constants/SupportedLanguages.dart';
import '../../contracts/search/dropdownOption.dart';
import 'package:flutter/material.dart';

class LanguageSelectionPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DropdownOption> options = supportedLanguageMaps
        .map((l) => DropdownOption(
              getTranslations().fromKey(l.name),
              value: l.code,
            ))
        .toList();
    options.sort((a, b) => a.title.compareTo(b.title));

    return OptionsListPageDialog(
      getTranslations().fromKey(LocaleKey.language),
      options,
      minListForSearch: 25,
      customPresenter: (BuildContext innerC, DropdownOption opt, int) {
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
