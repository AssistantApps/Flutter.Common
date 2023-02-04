import 'package:flutter/material.dart';

import '../../components/tilePresenters/language_tile_presenter.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/localization_map.dart';
import '../../contracts/search/dropdown_option.dart';
import '../../integration/dependency_injection.dart';
import '../dialog/options_list_page_dialog.dart';

class LanguageSelectionPageContent extends StatelessWidget {
  const LanguageSelectionPageContent({Key? key}) : super(key: key);

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
        LocalizationMap supportedLang = supportedLanguageMaps //
            .firstWhere((sl) => sl.code == opt.value);
        return languageTilePresenter(
          innerC,
          opt.title,
          supportedLang.countryCode,
          onTap: () => getNavigation().pop(context, opt.value),
        );
      },
    );
  }
}
