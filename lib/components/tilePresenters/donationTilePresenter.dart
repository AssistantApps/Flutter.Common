import 'package:assistantapps_flutter_common/constants/UIConstants.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/donationType.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../helpers/dateHelper.dart';
import 'genericTilePresenter.dart';

Widget donationTilePresenter(BuildContext context, DonationViewModel donator) =>
    genericListTileWithSubtitle(
      context,
      leadingImage: getImage(donator.type),
      imagePackage: UIConstants.CommonPackage,
      name: donator.username,
      subtitle: Text(
        simpleDate(donator.date.toLocal()),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
