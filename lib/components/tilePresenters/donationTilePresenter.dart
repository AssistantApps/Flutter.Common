import 'package:flutter/material.dart';

import '../../contracts/enum/donationType.dart';
import '../../contracts/generated/donationViewModel.dart';
import '../../contracts/types/listTypes.dart';
import '../../helpers/dateHelper.dart';
import '../common/donationImage.dart';

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
    case DonationType.APPLEPLAY:
      return DonationImage.applePay();
    case DonationType.BRAVEREWARDS:
      return DonationImage.bat();
    case DonationType.BUYMEACOFFEE:
      return DonationImage.buyMeACoffee();
    case DonationType.GOOGLEPLAY:
      return DonationImage.googlePay();
    case DonationType.KOFI:
      return DonationImage.kofi();
    case DonationType.OPENCOLLECTIVE:
      return DonationImage.openCollective();
    case DonationType.PATREON:
      return DonationImage.patreon();
    case DonationType.PAYPAL:
      return DonationImage.payPal();
    case DonationType.UNKNOWN:
    default:
      return DonationImage.unknown();
  }
}
