import 'package:flutter/material.dart';

import '../../components/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/versionTilePresenter.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../services/api/interface/IversionApiService.dart';

class WhatIsNewPageWidget extends StatelessWidget {
  final String currentWhatIsNewGuid;
  final String release;
  final String current;
  final String pendingAppStoreRelease;
  final Color lineColour;
  final String selectedLanguage;
  final List<PlatformType> platforms;
  final Widget loadMoreItemWidget;
  final void Function(VersionViewModel) onTap;
  final IVersionApiService versionApiService;

  WhatIsNewPageWidget(
      this.currentWhatIsNewGuid,
      this.release,
      this.current,
      this.pendingAppStoreRelease,
      this.lineColour,
      this.selectedLanguage,
      this.platforms,
      this.loadMoreItemWidget,
      this.onTap,
      this.versionApiService,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadSearchableList<VersionViewModel>(
      (int page) => versionApiService.getHistory(
        selectedLanguage,
        platforms,
        page: page,
      ),
      20,
      versionTilePresenter(
        context,
        currentWhatIsNewGuid,
        release,
        current,
        pendingAppStoreRelease,
        lineColour,
        onTap,
      ),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
