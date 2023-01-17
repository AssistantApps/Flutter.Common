import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import 'tilePresenters/app_notice_tile_presenter.dart';

class AppNotices extends StatefulWidget {
  final Widget child;

  const AppNotices({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  createState() => _AppNoticesWidget();
}

class _AppNoticesWidget extends State<AppNotices>
    with AfterLayoutMixin<AppNotices> {
  NetworkState networkState = NetworkState.Loading;
  List<AppNoticeViewModel> notices = List.empty(growable: true);

  @override
  void afterFirstLayout(BuildContext context) => checkForNotices(context);

  Future<void> checkForNotices(BuildContext context) async {
    ResultWithValue<List<AppNoticeViewModel>> apiResult =
        await getAssistantAppsApi().getAppNotices(
      getTranslations().currentLanguage,
    );
    bool hasNotices = apiResult.isSuccess && apiResult.value.isNotEmpty;
    if (hasNotices == false) return;

    setState(() {
      notices = apiResult.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...notices.map(appNoticeTileCore).toList(),
        Expanded(child: widget.child),
      ],
    );
  }
}
