import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/donationType.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../helpers/dateHelper.dart';
import 'genericTilePresenter.dart';

Widget donationTilePresenter(BuildContext context, DonationViewModel donator) =>
    ListTile(
      leading: Padding(
        padding: EdgeInsets.all(4),
        child: genericTileImage(
          '${AppImage.donationsFolder}${getImage(donator.type)}',
          imagePackage: UIConstants.CommonPackage,
        ),
      ),
      title: normalText(donator.username),
      subtitle: normalText(simpleDate(donator.date.toLocal())),
    );

Widget normalText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
