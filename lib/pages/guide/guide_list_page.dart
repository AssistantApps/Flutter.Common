import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../components/adaptive/search_bar.dart';
import '../../components/common/cached_future_builder.dart';
import '../../components/common/text.dart';
import '../../components/list/pagination_searchable_list.dart';
import '../../components/tilePresenters/guide_tile_presenter.dart';
import '../../constants/app_image.dart';
import '../../constants/local_storage_key.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/guide/guide_content_view_model.dart';
import '../../contracts/generated/guide/guide_search_result_view_model.dart';
import '../../contracts/generated/guide/guide_search_view_model.dart';
import '../../contracts/guide/guide_draft_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/column_helper.dart';
import '../../helpers/guid_helper.dart';
import '../../integration/dependency_injection.dart';
import 'guide_add_edit_page.dart';

class GuideListPage extends StatefulWidget {
  final GuideDraftModel draftModel;

  GuideListPage({
    super.key,
    required String analyticsKey,
    required this.draftModel,
  }) {
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
      AdaptiveSearchBar(
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
