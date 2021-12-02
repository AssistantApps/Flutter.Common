import '../../components/tilePresenters/languageTilePresenter.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/localizationMap.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../integration/dependencyInjection.dart';
import '../../pages/dialog/optionsListPageDialog.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/appBar.dart';
import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../contracts/misc/actionItem.dart';
import 'interface/IBaseWidgetService.dart';

class BaseWidgetService implements IBaseWidgetService {
  Widget appScaffold(
    BuildContext context, {
    @required Widget appBar,
    Widget body,
    Widget Function(BuildContext scaffoldContext) builder,
    Widget drawer,
    Widget bottomNavigationBar,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
  }) =>
      adaptiveAppScaffold(
        context,
        appBar: appBar,
        body: body,
        builder: builder,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );

  Widget appBar(BuildContext context, Widget title, List<Widget> actions,
          {Widget leading, PreferredSizeWidget bottom}) =>
      adaptiveAppBar(context, title, actions, leading: leading, bottom: bottom);

  Widget appBarForSubPage(
    BuildContext context, {
    Widget title,
    List<ActionItem> actions,
    List<ActionItem> shortcutActions,
    bool showHomeAction = false,
    bool showBackAction = true,
  }) =>
      adaptiveAppBarForSubPageHelper(
        context,
        title: title,
        actions: actions,
        shortcutActions: shortcutActions,
        showBackAction: showBackAction,
        showHomeAction: showHomeAction,
      );

  @override
  Future<String> langaugeSelectionPage(BuildContext context) async {
    List<LocalizationMap> supportedLanguageMaps =
        getLanguage().getLocalizationMaps();
    List<DropdownOption> orderedLangs = supportedLanguageMaps
        .map((l) => DropdownOption(
              getTranslations().fromKey(l.name),
              value: l.code,
            ))
        .toList();
    orderedLangs.sort((a, b) => a.title.compareTo(b.title));
    return await getNavigation().navigateAsync<String>(
      context,
      navigateTo: (context) => OptionsListPageDialog(
        getTranslations().fromKey(LocaleKey.language),
        orderedLangs,
        minListForSearch: 15,
        customPresenter: (BuildContext innerC, DropdownOption opt, int index) {
          LocalizationMap supportedLang =
              supportedLanguageMaps.firstWhere((sl) => sl.code == opt.value);
          return languageTilePresenter(
            innerC,
            opt.title,
            supportedLang.countryCode,
            onTap: () => Navigator.of(context).pop(opt.value),
          );
        },
      ),
    );
  }
}
