import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../components/list/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/donationTilePresenter.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/generated/donationViewModel.dart';

class DonatorsPageWidget extends StatelessWidget {
  final Widget loadMoreItemWidget;
  const DonatorsPageWidget(this.loadMoreItemWidget, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadSearchableList<DonationViewModel>(
      (int page) => getAssistantAppsDonators().getDonators(page: page),
      UIConstants.DonationsPageSize,
      donationTilePresenter,
      backupListGetter: (int page) => getAssistantAppsBackup().getDonations(
        context,
        page: page,
        pageSize: UIConstants.DonationsPageSize,
      ),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
