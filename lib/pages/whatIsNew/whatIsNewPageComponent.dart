import 'package:flutter/material.dart';

import '../../components/list/lazy_loaded_searchable_list.dart';
import '../../components/tilePresenters/version_tile_presenter.dart';
import '../../contracts/enum/platform_type.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../integration/dependencyInjection.dart';

class WhatIsNewPageComponent extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final String selectedLanguage;
  final List<PlatformType> platforms;
  final Widget loadMoreItemWidget;
  final void Function(VersionViewModel) onTap;

  const WhatIsNewPageComponent(
    this.currentWhatIsNewGuid,
    this.selectedLanguage,
    this.platforms,
    this.loadMoreItemWidget,
    this.onTap, {
    Key? key,
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
      listItemWithIndexDisplayer: versionTilePresenter(
        context,
        currentWhatIsNewGuid,
        onTap,
      ),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
