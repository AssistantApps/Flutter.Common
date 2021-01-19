import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/donationType.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../helpers/dateHelper.dart';
import 'genericTilePresenter.dart';

Widget donationTilePresenter(BuildContext context, DonationViewModel donator) =>
    genericListTileWithSubtitle(
      context,
      leadingImage: '${AppImage.donationsFolder}${getImage(donator.type)}',
      imagePackage: UIConstants.CommonPackage,
      name: donator.username,
      subtitle: Text(
        simpleDate(donator.date.toLocal()),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
