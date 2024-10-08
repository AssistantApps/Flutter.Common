import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../helpers/colour_helper.dart';
import '../../integration/dependency_injection.dart';
import '../common/image.dart';

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
    BorderRadius? borderRadius,
    bool? dense,
    bool? removeContentPadding,
    Function()? onTap,
    Function()? onLongPress}) {
  String title = description != null //
      ? '$name - $description'
      : name;
  if (title.isEmpty) title = ' ';

  return ListTile(
    leading: genericTileImage(
      leadingImage,
      imageHero: leadingImageHero,
      imagePackage: imagePackage,
      imageBackgroundColour: imageBackgroundColour,
      borderRadius: borderRadius,
    ),
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    contentPadding: removeContentPadding == true ? EdgeInsets.all(0) : null,
    dense: dense,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

ListTile genericListTileWithSubtitleAndImageCount(
  BuildContext context, {
  required Widget? leadingImage,
  int? leadingImageCount,
  bool? imageGreyScale = false,
  required String title,
  Widget? subtitle,
  int maxLines = 1,
  String? onTapAnalyticsEvent,
  String? onLongPressAnalyticsEvent,
  Widget? trailing,
  bool? dense,
  Function()? onTap,
  Function()? onLongPress,
}) {
  Widget? leadingImageWidget =
      (leadingImageCount != null && leadingImageCount > 0)
          // ? leadingImage
          ? getBaseWidget().basicBadge(
              text: leadingImageCount.toString(),
              child: leadingImage,
            )
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
    dense: dense,
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
    BorderRadius? borderRadius,
    bool? dense,
    bool? removeContentPadding,
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
    borderRadius: borderRadius,
    removeContentPadding: removeContentPadding,
    dense: dense,
    onTap: onTap,
    onLongPress: onLongPress,
  );
}

ListTile genericListTileWithNetworkImage(
  context, {
  required String imageUrl,
  BorderRadius? borderRadius,
  required String name,
  String? description,
  Widget? subtitle,
  int maxLines = 1,
  String? onTapAnalyticsEvent,
  String? onLongPressAnalyticsEvent,
  Widget? trailing,
  bool? dense,
  Function()? onTap,
  Function()? onLongPress,
}) {
  String title = description != null //
      ? '$name - $description'
      : name;
  Widget networkImage = ImageFromNetwork(
    imageUrl: imageUrl,
    boxfit: BoxFit.contain,
    height: 50.0,
    width: 50.0,
  );
  if (borderRadius != null) {
    networkImage = ClipRRect(
      borderRadius: borderRadius,
      child: networkImage,
    );
  }
  return ListTile(
    leading: networkImage,
    title: Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle,
    trailing: trailing,
    dense: dense,
    onTap: (onTap != null) ? onTap : null,
    onLongPress: (onLongPress != null) ? onLongPress : null,
  );
}

Widget? genericTileImage(
  String? leadingImage, {
  String? imageHero,
  String? imagePackage,
  String? imageBackgroundColour,
  BorderRadius? borderRadius,
}) {
  if (leadingImage == null) return null;
  String fullPath = leadingImage;
  if (imagePackage == null) {
    fullPath = getPath().ofImage(leadingImage);
  }

  Widget child = LocalImage(
    imagePath: fullPath,
    imageHero: imageHero,
    imagePackage: imagePackage,
    borderRadius: borderRadius,
  );
  if (imageBackgroundColour == null) return child;

  Widget container = Container(
    color: HexColor(imageBackgroundColour),
    child: child,
  );
  if (borderRadius != null) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: container,
    );
  }

  return container;
}
