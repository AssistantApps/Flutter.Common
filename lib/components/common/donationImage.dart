import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import './image.dart';

class DonationImage {
  static Widget applePay({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donApplePay,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget bat({double size = 35, EdgeInsets? padding}) => ListTileImage(
        partialPath: AppImage.donBat,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget buyMeACoffee({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donBuyMeACoffee,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget googlePay({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donGooglePay,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget kofi({double size = 35, EdgeInsets? padding}) => ListTileImage(
        partialPath: AppImage.donKofi,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget openCollective({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donOpenCollective,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget patreon(
          {double size = 35, EdgeInsets? padding, bool useAlt = false}) =>
      ListTileImage(
        partialPath: useAlt ? AppImage.donPatreonAlt : AppImage.donPatreon,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget payPal({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donPayPal,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );

  static Widget unknown({double size = 35, EdgeInsets? padding}) =>
      ListTileImage(
        partialPath: AppImage.donUnknown,
        size: size,
        padding: padding,
        package: UIConstants.commonPackage,
      );
}
