import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../components/list/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/versionTilePresenter.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';

class WhatIsNewPageComponent extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final String selectedLanguage;
  final List<PlatformType> platforms;
  final Widget loadMoreItemWidget;
  final void Function(VersionViewModel) onTap;

  WhatIsNewPageComponent(
    this.currentWhatIsNewGuid,
    this.selectedLanguage,
    this.platforms,
    this.loadMoreItemWidget,
    this.onTap, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadSearchableList<VersionViewModel>(
      (int page) => getAssistantAppsVersions().getHistory(
        selectedLanguage,
        platforms,
        page: page,
      ),
      20,
      listItemWithIndexDisplayer:
          versionTilePresenter(context, currentWhatIsNewGuid, onTap),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
