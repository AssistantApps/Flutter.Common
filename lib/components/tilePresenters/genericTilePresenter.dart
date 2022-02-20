import 'package:assistantapps_flutter_common/components/common/badge.dart';
import 'package:assistantapps_flutter_common/components/common/image.dart';
import 'package:assistantapps_flutter_common/contracts/enum/localeKey.dart';
import 'package:assistantapps_flutter_common/helpers/colourHelper.dart';
import 'package:assistantapps_flutter_common/helpers/deviceHelper.dart';
import 'package:assistantapps_flutter_common/integration/dependencyInjection.dart';
import 'package:flutter/material.dart';

ListTile genericListTileWithSubtitle(context,
    {required String? leadingImage,
    String? leadingImageHero,
    String? imageBackgroundColour,
    String? imagePackage,
    required String name,
    String? description,
    Widget? subtitle,
    int maxLines = 1,
    Widget? trailing,
    Function()? onTap,
    Function()? onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  if (title.length == 0) title = ' ';

  return ListTile(
    leading: genericTileImage(
      leadingImage,
      imageHero: leadingImageHero,
      imagePackage: imagePackage,
      imageBackgroundColour: imageBackgroundColour,
    ),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    // dense: true,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

ListTile genericListTileWithSubtitleAndImageCount(BuildContext context,
    {required Widget leadingImage,
    int? leadingImageCount,
    bool? imageGreyScale = false,
    required String title,
    Widget? subtitle,
    int maxLines = 1,
    String? onTapAnalyticsEvent,
    String? onLongPressAnalyticsEvent,
    Widget? trailing,
    Function()? onTap,
    Function()? onLongPress}) {
  var leadingImageWidget = (leadingImageCount != null && leadingImageCount > 0)
      // ? leadingImage
      ? basicBadge(context, leadingImageCount.toString(), leadingImage)
      : leadingImage;
  return ListTile(
    leading: leadingImageWidget,
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    // dense: true,
    onTap: () {
      if (onTapAnalyticsEvent != null) {
        getAnalytics().trackEvent(onTapAnalyticsEvent);
      }
      if (onTap != null) {
        onTap();
      }
    },
    onLongPress: () {
      if (onLongPressAnalyticsEvent != null) {
        getAnalytics().trackEvent(onLongPressAnalyticsEvent);
      }
      if (onLongPress != null) {
        onLongPress();
      }
    },
  );
}

ListTile genericListTile(context,
    {required String? leadingImage,
    String? leadingImageHero,
    String? imageBackgroundColour,
    required String name,
    String? description,
    int? quantity,
    int maxLines = 1,
    String? onLongPressAnalyticsEvent,
    Widget? trailing,
    Function()? onTap,
    Function()? onLongPress}) {
  Widget? subtitle = (quantity != null && quantity > 0)
      ? Text(
          "${getTranslations().fromKey(LocaleKey.quantity)}: ${quantity.toString()}")
      : null;
  return genericListTileWithSubtitle(
    context,
    leadingImage: leadingImage,
    leadingImageHero: leadingImageHero,
    imageBackgroundColour: imageBackgroundColour,
    name: name,
    description: description,
    subtitle: subtitle,
    maxLines: maxLines,
    trailing: trailing,
    onTap: onTap,
    onLongPress: onLongPress,
  );
}

ListTile genericListTileWithNetworkImage(context,
    {required String imageUrl,
    required String name,
    String? description,
    Widget? subtitle,
    int maxLines = 1,
    String? onTapAnalyticsEvent,
    String? onLongPressAnalyticsEvent,
    Widget? trailing,
    Function()? onTap,
    Function()? onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  return ListTile(
    leading: isWeb
        ? Image.network(
            imageUrl,
            height: 50.0,
            width: 50.0,
          )
        : networkImage(
            imageUrl,
            boxfit: BoxFit.contain,
            height: 50.0,
            width: 50.0,
          ),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    //dense: true,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

Widget? genericTileImage(
  String? leadingImage, {
  String? imageHero,
  String? imagePackage,
  String? imageBackgroundColour,
}) {
  if (leadingImage == null) return null;
  String prefix = '';
  if (imagePackage == null) {
    String imageAssetsPathPrefix = getPath().imageAssetPathPrefix;
    if (!leadingImage.contains(imageAssetsPathPrefix)) {
      prefix = '$imageAssetsPathPrefix/';
    }
  }

  String fullPath = '$prefix$leadingImage';
  Widget child = localImage(
    fullPath,
    imageHero: imageHero,
    imagePackage: imagePackage,
  );
  if (imageBackgroundColour == null) return child;

  return Container(
    child: child,
    color: HexColor(imageBackgroundColour),
  );
}
