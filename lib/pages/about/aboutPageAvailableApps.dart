import 'package:flutter/material.dart';

import '../../components/common/cached_future_builder.dart';
import '../../components/common/image.dart';
import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../components/tilePresenters/assistantAppLinkPresenter.dart';
import '../../components/tilePresenters/genericTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/assistantAppType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/appsLinkViewModel.dart';
import '../../contracts/misc/popupMenuaction_item.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../helpers/stringHelper.dart';
import '../../integration/dependencyInjection.dart';

class AboutPageAvailableApps extends StatelessWidget {
  final AssistantAppType appType;

  const AboutPageAvailableApps(this.appType, {Key? key}) : super(key: key);

  Future<List<AssistantAppsLinkViewModel>> getAppLinksFuture(
      BuildContext context) async {
    ResultWithValue<List<AssistantAppsLinkViewModel>> assistantAppsResult =
        await getAssistantAppsData().getAssistantApps(context);
    if (assistantAppsResult.hasFailed) return List.empty();

    List<AssistantAppsLinkViewModel> sortModifiedAssistantAppLinks =
        List.empty(growable: true);

    for (AssistantAppsLinkViewModel item
        in assistantAppsResult.value.toList()) {
      int newSortOrder = item.type == appType ? -10 : item.sortOrder;
      sortModifiedAssistantAppLinks.add(item.copyWith(sortOrder: newSortOrder));
    }
    sortModifiedAssistantAppLinks.sort(
      (a, b) => (a.sortOrder.compareTo(b.sortOrder)),
    );

    return sortModifiedAssistantAppLinks;
  }

  @override
  Widget build(BuildContext context) {
    return CachedFutureBuilder(
      future: getAppLinksFuture(context),
      whileLoading: () => getLoading().fullPageLoading(context),
      whenDoneLoading: (List<AssistantAppsLinkViewModel> assistantAppLinks) {
        List<Widget> widgets = List.empty(growable: true);

        widgets.add(const EmptySpace1x());
        widgets.add(
          const LocalImage(
            imagePath: '${AppImage.base}${AppImage.assistantApps}',
            imagePackage: UIConstants.commonPackage,
            height: 75,
          ),
        );
        widgets.add(GenericItemName(
          getTranslations().fromKey(LocaleKey.assistantApps),
        ));
        widgets.add(const GenericItemDescription(
          'This app is part of the AssistantApps range',
        ));

        widgets.add(customDivider());

        for (AssistantAppsLinkViewModel appLinkVm in assistantAppLinks) {
          List<PopupMenuActionItem> popups = List.empty(growable: true);
          for (Link appLink in appLinkVm.links) {
            if (isiOS == false && appLink.type == 'android') {
              popups.add(PopupMenuActionItem(
                icon: Icons.phone_android,
                text: 'Android',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.type == 'ios') {
              popups.add(PopupMenuActionItem(
                icon: Icons.phone_iphone,
                text: 'iOS',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.type == 'web') {
              popups.add(PopupMenuActionItem(
                icon: Icons.language,
                text: 'Web',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
          }

          String platStr =
              joinStringList(popups.map((p) => p.text).toList(), ', ');
          String platforms = 'Available on: $platStr';

          widgets.add(
            assistantAppLinkPresenter(context, appLinkVm, platforms, popups),
          );
          widgets.add(const EmptySpace1x());
        }

        widgets.add(
          Card(
            child: genericListTileWithSubtitle(
              context,
              leadingImage: '${AppImage.base}${AppImage.unknown}',
              imagePackage: UIConstants.commonPackage,
              name: 'Coming soon',
            ),
          ),
        );
        widgets.add(const EmptySpace(1));

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: widgets.length,
          itemBuilder: (_, int index) => widgets[index],
          shrinkWrap: true,
          controller: ScrollController(),
        );
      },
    );
  }
}
