import 'package:assistantapps_flutter_common/contracts/results/resultWithValue.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../components/adaptive/searchBar.dart';
import '../../components/dialogs/prettyDialog.dart';
import '../../components/list/paginationSearchableList.dart';
import '../../components/tilePresenters/guideTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/LocalStorageKey.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/generated/guide/guideSearchViewModel.dart';
import '../../contracts/guide/guideDraftModel.dart';
import '../../helpers/columnHelper.dart';
import '../../helpers/guidHelper.dart';
import '../../integration/dependencyInjection.dart';
import './guideAddEditPage.dart';

class GuideListPage extends StatefulWidget {
  final GuideDraftModel draftModel;
  GuideListPage({
    required String analyticsKey,
    required this.draftModel,
  }) {
    getAnalytics().trackEvent(analyticsKey);
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
      body: getBody(widget.draftModel, this.searchObj.getHash()),
      floatingActionButton: FloatingActionButton(
        heroTag: 'AddGuide',
        child: Icon(Icons.add),
        backgroundColor: getTheme().fabColourSelector(context),
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        onPressed: onFabPress,
      ),
    );
  }

  Future<void> onFabPress() async {
    ResultWithValue<String> assistantAppsToken =
        await getSecureStorageRepo().loadStringFromStorageCheckExpiry(
      LocalStorageKey.assistantAppsJwtToken,
    );
    if (assistantAppsToken.hasFailed) {
      prettyDialogWithWidget(
        context,
        WebsafeSvg.asset(AppImage.authSVG, package: UIConstants.CommonPackage),
        getTranslations().fromKey(LocaleKey.loginRequiredTitle),
        getTranslations().fromKey(LocaleKey.loginRequiredMessage),
        onSuccess: widget.draftModel.googleLogin,
        onCancel: () {
          getNavigation().pop(context);
        },
      );
      return;
    }
    getNavigation().navigateAwayFromHomeAsync(
      context,
      navigateTo: (context) => GuideAddEditPage(
        GuideContentViewModel.newGuide(
          getNewGuid(),
          widget.draftModel.selectedLanguage,
        ),
        List.empty(growable: true),
        draftModel: widget.draftModel,
        isEdit: false,
      ),
    );
  }

  Widget getBody(GuideDraftModel draftModel, String searchObjHash) {
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
                languageCode: draftModel.selectedLanguage,
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
