import 'package:flutter/material.dart';

import '../../components/common/cached_future_builder.dart';
import '../../components/common/card.dart';
import '../../components/common/icon.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/guide/guide_content_view_model.dart';
import '../../contracts/generated/guide/guide_section_item_view_model.dart';
import '../../contracts/generated/guide/guide_section_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/date_helper.dart';
import '../../integration/dependency_injection.dart';
import './section/displayguide_section.dart';

class GuideViewPage extends StatelessWidget {
  final String? analyticsKey;
  final String guideContentGuid;

  GuideViewPage({
    Key? key,
    this.analyticsKey,
    required this.guideContentGuid,
  }) : super(key: key) {
    if (analyticsKey != null) getAnalytics().trackEvent(analyticsKey!);
  }

  @override
  Widget build(BuildContext context) {
    return CachedFutureBuilder(
      future: getAssistantAppsGuide().getGuideContent(guideContentGuid),
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
            title: Text(
              guideContentResult.isSuccess
                  ? guideContentResult.value.title
                  : 'Error',
            ), // TODO translate
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
    sectionWidgets.add(textItem(simpleDate(guideContent.dateCreated)));
    if (guideContent.showCreatedByUser &&
        guideContent.userName != null &&
        guideContent.userName!.isNotEmpty) {
      sectionWidgets.add(textItem(guideContent.userName!));
    }
    sectionWidgets.add(FlatCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // iconWithValueRow(
            //   Icons.thumb_up,
            //   guideContent.likes,
            //   colour: getPrimaryColour(context),
            // ),
            IconWithValueRow(Icons.thumb_up, guideContent.likes),
            IconWithValueRow(Icons.remove_red_eye, guideContent.views),
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
