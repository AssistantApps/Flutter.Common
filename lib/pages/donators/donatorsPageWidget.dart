import 'package:flutter/material.dart';

import '../../components/list/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/donationTilePresenter.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../services/api/interface/IDonatorApiService.dart';
import '../../services/json/interface/IbackupJsonService.dart';

class DonatorsPageWidget extends StatelessWidget {
  final IDonatorApiService donatorApiService;
  final IBackupJsonService backupJsonService;
  final Widget loadMoreItemWidget;
  const DonatorsPageWidget(
      this.donatorApiService, this.backupJsonService, this.loadMoreItemWidget,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LazyLoadSearchableList<DonationViewModel>(
      (int page) => donatorApiService.getDonators(page: page),
      UIConstants.DonationsPageSize,
      donationTilePresenter,
      backupListGetter: (int page) => backupJsonService.getDonations(
        context,
        page: page,
        pageSize: UIConstants.DonationsPageSize,
      ),
      loadMoreItemWidget: loadMoreItemWidget,
    );
  }
}
