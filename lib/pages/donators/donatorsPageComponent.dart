import 'package:flutter/material.dart';

import '../../components/list/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/donationTilePresenter.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../integration/dependencyInjection.dart';

class DonatorsPageComponent extends StatelessWidget {
  final Widget loadMoreItemWidget;
  const DonatorsPageComponent(this.loadMoreItemWidget, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadSearchableList<DonationViewModel>(
      (int page) => getAssistantAppsDonators().getDonators(page: page),
      UIConstants.DonationsPageSize,
      listItemDisplayer: donationTilePresenter,
      backupListGetter: (int page) => getAssistantAppsBackup().getDonations(
        context,
        page: page,
        pageSize: UIConstants.DonationsPageSize,
      ),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
