import 'package:flutter/material.dart';

import '../../components/common/cachedFutureBuilder.dart';
import '../../components/common/card.dart';
import '../../components/common/icon.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSectionItemViewModel.dart';
import '../../contracts/generated/guide/guideSectionViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import 'section/displayGuideSection.dart';

class GuideViewPage extends StatelessWidget {
  final String? analyticsKey;
  final String guideContentGuid;

  GuideViewPage({this.analyticsKey, required this.guideContentGuid}) {
    if (this.analyticsKey != null)
      getAnalytics().trackEvent(this.analyticsKey!);
  }

  @override
  Widget build(BuildContext context) {
    return CachedFutureBuilder(
      future: getAssistantAppsGuide().getGuideContent(this.guideContentGuid),
      whileLoading: () => getBaseWidget().appScaffold(
        context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          showHomeAction: true,
          title: Text(getTranslations().fromKey(LocaleKey.loading)),
        ),
        body: getLoading().fullPageLoading(context),
      ),
      whenDoneLoading:
          (ResultWithValue<GuideContentViewModel> guideContentResult) {
        return getBaseWidget().appScaffold(
          context,
          appBar: getBaseWidget().appBarForSubPage(
            context,
            title: Text(guideContentResult.isSuccess
                ? guideContentResult.value.title
                : 'Error'), // TODO translate
          ),
          body: getBody(context, guideContentResult),
        );
      },
    );
  }

  Widget getBody(BuildContext bodyCtx,
      ResultWithValue<GuideContentViewModel> guideContentResult) {
    List<Widget> widgets = List.empty(growable: true);
    if (!guideContentResult.isSuccess) {
      return getLoading().customErrorWidget(bodyCtx);
    }

    GuideContentViewModel guideContent = guideContentResult.value;

    List<Widget> sectionWidgets = List.empty(growable: true);
    sectionWidgets.add(textItem(guideContent.subTitle));
    sectionWidgets.add(textItem(guideContent.dateCreated.toIso8601String()));
    if (guideContent.showCreatedByUser &&
        guideContent.userName != null &&
        guideContent.userName!.isNotEmpty) {
      sectionWidgets.add(textItem(guideContent.userName!));
    }
    sectionWidgets.add(flatCard(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // iconWithValueRow(
            //   Icons.thumb_up,
            //   guideContent.likes,
            //   colour: getPrimaryColour(context),
            // ),
            iconWithValueRow(Icons.thumb_up, guideContent.likes),
            iconWithValueRow(Icons.remove_red_eye, guideContent.views),
          ],
        ),
      ),
    ));
    widgets.add(sectionListItem(bodyCtx, 'Details', sectionWidgets));

    for (GuideSectionViewModel section in guideContent.sections) {
      List<Widget> sectionItemWidgets = List.empty(growable: true);
      for (GuideSectionItemViewModel sectionItem in section.items) {
        Widget? sectionItemItemWidget = getSectionItem(bodyCtx, sectionItem);
        if (sectionItemItemWidget != null) {
          sectionItemWidgets.add(sectionItemItemWidget);
        }
      }
      widgets.add(
        sectionListItem(bodyCtx, section.heading, sectionItemWidgets),
      );
    }

    return CustomScrollView(shrinkWrap: true, slivers: widgets);
  }
}
