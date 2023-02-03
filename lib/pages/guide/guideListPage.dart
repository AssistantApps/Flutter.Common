import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../components/adaptive/search_bar.dart';
import '../../components/common/cached_future_builder.dart';
import '../../components/common/text.dart';
import '../../components/list/pagination_searchable_list.dart';
import '../../components/tilePresenters/guideTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/LocalStorageKey.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/generated/guide/guideSearchViewModel.dart';
import '../../contracts/guide/guideDraftModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/columnHelper.dart';
import '../../helpers/guidHelper.dart';
import '../../integration/dependencyInjection.dart';
import 'guideAddEditPage.dart';

class GuideListPage extends StatefulWidget {
  final GuideDraftModel draftModel;

  GuideListPage({
    Key? key,
    required String analyticsKey,
    required this.draftModel,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  // ignore: no_logic_in_create_state
  createState() => _GuideListWidget(
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
      body: getBody(widget.draftModel, searchObj.getHash()),
      floatingActionButton: CachedFutureBuilder(
        future: getSecureStorageRepo().loadStringFromStorageCheckExpiry(
          LocalStorageKey.assistantAppsJwtToken,
        ),
        whileLoading: () => addGuideFab(
          context,
          getLoading().smallLoadingIndicator(),
          () {},
        ),
        whenDoneLoading: (ResultWithValue<String> aaTokenResult) {
          if (aaTokenResult.hasFailed) {
            return addGuideFab(
              context,
              const Icon(Icons.add),
              () => getDialog().showSimpleDialog(
                context,
                getTranslations().fromKey(LocaleKey.loginRequiredTitle),
                Column(
                  children: [
                    WebsafeSvg.asset(
                      AppImage.authSVG,
                      package: UIConstants.commonPackage,
                    ),
                    GenericItemDescription(
                      getTranslations().fromKey(LocaleKey.loginRequiredMessage),
                    ),
                  ],
                ),
                buttonBuilder: (BuildContext btnContext) {
                  return [
                    getDialog().simpleDialogPositiveButton(
                      btnContext,
                      onTap: () => widget.draftModel.googleLogin(),
                    ),
                    getDialog().simpleDialogCloseButton(
                      btnContext,
                      onTap: () => getNavigation().pop(btnContext),
                    ),
                  ];
                },
              ),
            );
          }

          return addGuideFab(
            context,
            const Icon(Icons.add),
            () => getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (_) => GuideAddEditPage(
                GuideContentViewModel.newGuide(
                  getNewGuid(),
                  widget.draftModel.selectedLanguage,
                ),
                List.empty(growable: true),
                draftModel: widget.draftModel,
                isEdit: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget addGuideFab(BuildContext fabCtx, Widget child, void Function() onTap) {
    return FloatingActionButton(
      heroTag: 'AddGuide',
      backgroundColor: getTheme().fabColourSelector(fabCtx),
      foregroundColor: getTheme().fabForegroundColourSelector(fabCtx),
      onPressed: onTap,
      child: child,
    );
  }

  Widget getBody(GuideDraftModel draftModel, String searchObjHash) {
    List<Widget> columnWidgets = List.empty(growable: true);
    columnWidgets.add(
      SearchBar(
        controller: TextEditingController(),
        onSearchTextChanged: (String search) {
          setState(() {
            searchObj = searchObj.copyWith(name: search);
          });
        },
      ),
    );
    columnWidgets.add(Expanded(
      child: PaginationSearchableList<GuideSearchResultViewModel>(
        (int page) => getAssistantAppsGuide().getAllGuides(
          searchObj.copyWith(
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
