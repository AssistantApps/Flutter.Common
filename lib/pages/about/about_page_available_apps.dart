import 'package:flutter/material.dart';

import '../../components/common/cached_future_builder.dart';
import '../../components/common/content_horizontal_spacing.dart';
import '../../components/common/image.dart';
import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../components/tilePresenters/assistant_app_link_presenter.dart';
import '../../components/tilePresenters/generic_tile_presenter.dart';
import '../../constants/app_image.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/apps_link_view_model.dart';
import '../../contracts/misc/popup_menu_action_item.dart';
import '../../contracts/results/result_with_value.dart';
import '../../helpers/device_helper.dart';
import '../../helpers/external_helper.dart';
import '../../helpers/string_helper.dart';
import '../../integration/dependency_injection.dart';

class AboutPageAvailableApps extends StatelessWidget {
  final AssistantAppType appType;
  final ScrollController? controller;

  const AboutPageAvailableApps(
    this.appType, {
    this.controller,
    super.key,
  });

  Future<List<AssistantAppsLinkViewModel>> getAppLinksFuture(
      BuildContext context) async {
    ResultWithValue<List<AssistantAppsLinkViewModel>> assistantAppsResult =
        await getAssistantAppsData().getAssistantApps(context);
    if (assistantAppsResult.hasFailed) return List.empty();

    return assistantAppsResult.value;
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
          for (AssistantAppsLinkLinkViewModel appLink in appLinkVm.links) {
            if (isiOS == false && appLink.icon == 'googlePlay') {
              popups.add(PopupMenuActionItem(
                icon: Icons.phone_android,
                text: 'Android',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.icon == 'apple') {
              popups.add(PopupMenuActionItem(
                icon: Icons.phone_iphone,
                text: 'iOS',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.icon == 'web') {
              popups.add(PopupMenuActionItem(
                icon: Icons.language,
                text: 'Web',
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.icon == 'windows') {
              popups.add(PopupMenuActionItem(
                icon: Icons.desktop_windows_rounded,
                text: appLink.title,
                onPressed: () => launchExternalURL(appLink.url),
              ));
            }
            if (appLink.icon == 'github') {
              popups.add(PopupMenuActionItem(
                icon: Icons.code,
                text: 'Github',
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
        widgets.add(const EmptySpace1x());

        return ContentHorizontalSpacing(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: widgets.length,
            itemBuilder: (_, int index) => widgets[index],
            shrinkWrap: true,
            controller: controller ?? ScrollController(),
          ),
        );
      },
    );
  }
}
