import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import 'image.dart';

class DonationImage {
  static Widget applePay({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donApplePay,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget bat({double size = 35, EdgeInsets padding}) => getListTileImage(
        AppImage.donBat,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget buyMeACoffee({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donBuyMeACoffee,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget googlePay({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donGooglePay,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget kofi({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donKofi,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget openCollective({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donOpenCollective,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget patreon({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donPatreon,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget payPal({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donPayPal,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );

  static Widget unknown({double size = 35, EdgeInsets padding}) =>
      getListTileImage(
        AppImage.donUnknown,
        size: size,
        padding: padding,
        package: UIConstants.CommonPackage,
      );
}
