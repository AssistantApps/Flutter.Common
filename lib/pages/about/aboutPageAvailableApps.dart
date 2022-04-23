import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

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
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../helpers/stringHelper.dart';
import '../../integration/dependencyInjection.dart';

class AboutPageAvailableApps extends StatefulWidget {
  final AssistantAppType appType;
  AboutPageAvailableApps(this.appType);

  @override
  _AboutPageAvailableAppsWidget createState() =>
      _AboutPageAvailableAppsWidget();
}

class _AboutPageAvailableAppsWidget extends State<AboutPageAvailableApps>
    with AfterLayoutMixin<AboutPageAvailableApps> {
  late List<AssistantAppsLinkViewModel> assistantAppLinks;
  bool isLoading = true;
  _AboutPageAvailableAppsWidget() {
    assistantAppLinks = List.empty(growable: true);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getAppLinksFuture(context);
  }

  Future getAppLinksFuture(BuildContext context) async {
    ResultWithValue<List<AssistantAppsLinkViewModel>> assistantAppsResult =
        await getAssistantAppsData().getAssistantApps(context);
    if (assistantAppsResult.hasFailed) return;

    List<AssistantAppsLinkViewModel> sortModifiedAssistantAppLinks =
        List.empty(growable: true);

    for (AssistantAppsLinkViewModel item
        in assistantAppsResult.value.toList()) {
      int newSortOrder = item.type == widget.appType ? -10 : item.sortOrder;
      sortModifiedAssistantAppLinks.add(item.copyWith(sortOrder: newSortOrder));
    }
    sortModifiedAssistantAppLinks.sort(
      (a, b) => (a.sortOrder.compareTo(b.sortOrder)),
    );

    this.setState(() {
      isLoading = false;
      assistantAppLinks = sortModifiedAssistantAppLinks;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: getLoading().smallLoadingIndicator());
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(emptySpace1x());
    widgets.add(
      localImage(
        '${AppImage.base}${AppImage.assistantApps}',
        imagePackage: UIConstants.CommonPackage,
        height: 75,
      ),
    );
    widgets.add(
        genericItemName(getTranslations().fromKey(LocaleKey.assistantApps)));
    widgets.add(genericItemDescription(
      'This app is part of the AssistantApps range',
    ));

    widgets.add(Divider());

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
      String platforms = 'Available on: ' +
          joinStringList(
            popups.map((p) => p.text).toList(),
            ', ',
          );

      widgets.add(
        assistantAppLinkPresenter(context, appLinkVm, platforms, popups),
      );
      widgets.add(emptySpace1x());
    }

    widgets.add(
      Card(
        child: genericListTileWithSubtitle(
          context,
          leadingImage: '${AppImage.base}${AppImage.unknown}',
          imagePackage: UIConstants.CommonPackage,
          name: 'Coming soon',
        ),
      ),
    );
    widgets.add(emptySpace(1));

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widgets.length,
      itemBuilder: (_, int index) => widgets[index],
      shrinkWrap: true,
    );
  }
}
