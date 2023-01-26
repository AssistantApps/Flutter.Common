import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import 'tilePresenters/app_notice_tile_presenter.dart';

class AppNoticesWrapper extends StatefulWidget {
  final Widget child;

  const AppNoticesWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  createState() => _AppNoticesWrapperWidget();
}

class _AppNoticesWrapperWidget extends State<AppNoticesWrapper>
    with AfterLayoutMixin<AppNoticesWrapper> {
  //
  final Key _appNoticesKey = const Key('appnotices');
  NetworkState networkState = NetworkState.loading;
  List<AppNoticeViewModel> notices = List.empty(growable: true);

  @override
  void afterFirstLayout(BuildContext context) => checkForNotices(context);

  Future<void> checkForNotices(BuildContext context) async {
    ResultWithValue<List<AppNoticeViewModel>> apiResult =
        await getAssistantAppsApi().getAppNotices(
      getTranslations().currentLanguage,
    );
    bool hasNotices = apiResult.isSuccess && apiResult.value.isNotEmpty;
    if (hasNotices == false) {
      setState(() {
        networkState = NetworkState.error;
      });
      return;
    }

    setState(() {
      notices = apiResult.value;
      networkState = NetworkState.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    KeyedSubtree innerChild = KeyedSubtree(
      key: _appNoticesKey,
      child: widget.child,
    );

    if (notices.isEmpty) {
      return innerChild;
    }

    return Column(
      children: [
        ...notices
            .map((n) => AnimateScaleHeightFrom0ToFull(child: appNoticeTile(n)))
            .toList(),
        emptySpace1x(),
        Expanded(child: innerChild),
      ],
    );
  }
}
