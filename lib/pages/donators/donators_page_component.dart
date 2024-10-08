import 'package:flutter/material.dart';

import '../../components/common/content_horizontal_spacing.dart';
import '../../components/list/lazy_loaded_searchable_list.dart';
import '../../components/tilePresenters/donation_tile_presenter.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/generated/donation_view_model.dart';
import '../../integration/dependency_injection.dart';

class DonatorsPageComponent extends StatelessWidget {
  final Widget loadMoreItemWidget;
  const DonatorsPageComponent(this.loadMoreItemWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return ContentHorizontalSpacing(
      child: LazyLoadSearchableList<DonationViewModel>(
        (int page) => getAssistantAppsDonators().getDonators(page: page),
        UIConstants.donationsPageSize,
        listItemDisplayer: donationTilePresenter,
        backupListGetter: (int page) => getAssistantAppsBackup().getDonations(
          context,
          page: page,
          pageSize: UIConstants.donationsPageSize,
        ),
        loadMoreItemWidget: loadMoreItemWidget,
      ),
    );
  }
}
