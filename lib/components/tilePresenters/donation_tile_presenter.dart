import 'package:flutter/material.dart';

import '../../contracts/enum/donation_type.dart';
import '../../contracts/generated/donation_view_model.dart';
import '../../contracts/types/list_types.dart';
import '../../helpers/date_helper.dart';
import '../common/donation_image.dart';

ListItemDisplayerType<DonationViewModel> donationTilePresenter = (
  BuildContext context,
  DonationViewModel donator, {
  void Function()? onTap,
}) {
  return ListTile(
    leading: Padding(
      padding: const EdgeInsets.all(4),
      child: getImage(donator.type),
    ),
    title: normalText(donator.username),
    subtitle: normalText(simpleDate(donator.date.toLocal())),
  );
};

Widget normalText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

Widget getImage(DonationType donation) {
  switch (donation) {
    case DonationType.applePay:
      return DonationImage.applePay();
    case DonationType.braveRewards:
      return DonationImage.bat();
    case DonationType.buyMeACoffee:
      return DonationImage.buyMeACoffee();
    case DonationType.googlePlay:
      return DonationImage.googlePay();
    case DonationType.kofi:
      return DonationImage.kofi();
    case DonationType.openCollective:
      return DonationImage.openCollective();
    case DonationType.patreon:
      return DonationImage.patreon();
    case DonationType.paypal:
      return DonationImage.payPal();
    case DonationType.unknown:
      return DonationImage.unknown();
  }
}
