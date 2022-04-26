import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/list/paginationSearchableList.dart';
import '../../components/tilePresenters/guideTilePresenter.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/generated/guide/guideSearchViewModel.dart';
import '../../contracts/guide/settingsForGuideListPage.dart';
import '../../integration/dependencyInjection.dart';

class GuideListPage extends StatefulWidget {
  final String _analyticsKey;
  final SettingsForGuideListPage _settings;
  GuideListPage(this._analyticsKey, this._settings) {
    getAnalytics().trackEvent(_analyticsKey);
  }
  @override
  _GuideListWidget createState() => _GuideListWidget(
        GuideSearchViewModel.defaultSearch(),
      );
}

class _GuideListWidget extends State<GuideListPage> {
  GuideSearchViewModel searchObj;
  _GuideListWidget(this.searchObj);

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(getTranslations().fromKey(LocaleKey.guides)),
      ),
      // endDrawer: GuideDrawer(searchObj, (GuideSearchViewModel newSearchObj) {
      //   this.setState(() {
      //     this.searchObj = newSearchObj;
      //   });
      // }),
      body: getBody(widget._settings, this.searchObj.getHash()),
      floatingActionButton: FloatingActionButton(
        heroTag: 'AddGuide',
        child: Icon(Icons.add),
        backgroundColor: getTheme().fabColourSelector(context),
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        onPressed: () {
          // TODO Complete this
        },
      ),
    );
  }

  Widget getBody(SettingsForGuideListPage viewModel, String searchObjHash) {
    List<Widget> columnWidgets = List.empty(growable: true);
    columnWidgets.add(
      searchBar(context, TextEditingController(), null, (String search) {
        this.setState(() {
          this.searchObj = this.searchObj.copyWith(name: search);
        });
      }),
    );
    columnWidgets.add(Expanded(
      child: PaginationSearchableList<GuideSearchResultViewModel>(
        (int page) => getAssistantAppsGuide().getAllGuides(
          this.searchObj.copyWith(
                page: page,
                appGuid: getEnv().assistantAppsAppGuid,
                languageCode: viewModel.selectedLanguage,
              ),
        ),
        guideTilePresenter,
        (GuideSearchResultViewModel _, String __) => false,
        minListForSearch: 100000,
        useGridView: true,
        gridViewColumnCalculator: blogPostItemsCustomColumnCount,
        addFabPadding: true,
        customKey: 'BlogListPage',
        // firstListItemWidget: largePrevPageButton(context),
        // lastListItemWidget: largeNextPageButton(context),
      ),
    ));
    return Column(
      key: Key('GuideList+$searchObjHash'),
      children: columnWidgets,
    );
  }
}
