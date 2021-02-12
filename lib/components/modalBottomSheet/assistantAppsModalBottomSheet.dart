import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../components/common/image.dart';
import '../../components/tilePresenters/genericTilePresenter.dart';
import '../../constants/AppImage.dart';
import '../../constants/ExternalUrls.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/data/assistantAppLinks.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/misc/popupMenuActionItem.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../helpers/stringHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../common/space.dart';
import '../common/text.dart';
import '../tilePresenters/assistantAppLinkPresenter.dart';

class AssistantAppsModalBottomSheet extends StatefulWidget {
  @override
  _AssistantAppsModalBottomSheetWidget createState() =>
      _AssistantAppsModalBottomSheetWidget();
}

class _AssistantAppsModalBottomSheetWidget
    extends State<AssistantAppsModalBottomSheet>
    with
        TickerProviderStateMixin,
        AfterLayoutMixin<AssistantAppsModalBottomSheet> {
  List<AssistantAppLinks> assistantAppLinks;
  bool isLoading = true;
  _AssistantAppsModalBottomSheetWidget() {
    assistantAppLinks = List.empty(growable: true);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getAppLinksFuture(context);
  }

  Future getAppLinksFuture(BuildContext context) async {
    ResultWithValue<List<AssistantAppLinks>> assistantAppsResult =
        await getAssistantAppsData().getAssistantApps(context);
    if (assistantAppsResult.hasFailed) return;

    this.setState(() {
      isLoading = false;
      assistantAppLinks = assistantAppsResult.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(emptySpace(1));
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
    if (isLoading) {
      widgets.add(Center(child: getLoading().smallLoadingIndicator()));
    } else {
      widgets.add(Divider());
      for (AssistantAppLinks appLink in assistantAppLinks) {
        List<PopupMenuActionItem> popups = [
          if (appLink.ios != null) ...[
            PopupMenuActionItem(
              icon: Icons.phone_iphone,
              text: 'iOS',
              onPressed: () => launchExternalURL(appLink.ios),
            )
          ],
          if (appLink.android != null && !isApple) ...[
            PopupMenuActionItem(
              icon: Icons.phone_android,
              text: 'Android',
              onPressed: () => launchExternalURL(appLink.android),
            )
          ],
          if (appLink.web != null) ...[
            PopupMenuActionItem(
              icon: Icons.language,
              text: 'Web',
              onPressed: () => launchExternalURL(appLink.web),
            )
          ],
        ];
        String platforms = 'Available on: ' +
            joinStringList(
              popups.map((p) => p.text).toList(),
              ', ',
            );

        widgets.add(
          assistantAppLinkPresenter(context, appLink, platforms, popups),
        );
        widgets.add(emptySpace(1));
      }

      widgets.add(
        Card(
          child: genericListTileWithSubtitle(
            context,
            leadingImage: 'unknown.png',
            name: 'Coming soon',
          ),
        ),
      );
      widgets.add(emptySpace(1));
    }

    return Stack(
      children: [
        AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 150),
          child: Container(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height) / 2,
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: widgets.length,
              itemBuilder: (_, int index) => widgets[index],
              shrinkWrap: true,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () => launchExternalURL(
              ExternalUrls.assistantAppsWebsite,
            ),
          ),
        )
      ],
    );
  }
}
