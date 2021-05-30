import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/enum/localeKey.dart';
import '../../helpers/colourHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../common/image.dart';

ListTile genericListTileWithSubtitle(context,
    {@required String leadingImage,
    String imageBackgroundColour,
    String imagePackage,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  String title = description != null //
      ? name + ' - ' + description
      : name;
  if (title == null || title.length == 0) title = ' ';

  return ListTile(
    leading: genericTileImage(
      leadingImage,
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
    {@required Widget leadingImage,
    int leadingImageCount,
    bool imageGreyScale = false,
    @required String title,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
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
    {@required String leadingImage,
    String imageBackgroundColour,
    @required String name,
    String description,
    int quantity,
    int maxLines = 1,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
  Widget subtitle = (quantity != null && quantity > 0)
      ? Text(
          "${getTranslations().fromKey(LocaleKey.quantity)}: ${quantity.toString()}")
      : null;
  return genericListTileWithSubtitle(
    context,
    leadingImage: leadingImage,
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
    {@required String imageUrl,
    @required String name,
    String description,
    Widget subtitle,
    int maxLines = 1,
    String onTapAnalyticsEvent,
    String onLongPressAnalyticsEvent,
    Widget trailing,
    Function onTap,
    Function onLongPress}) {
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

Widget genericTileImage(
  String leadingImage, {
  String imagePackage,
  String imageBackgroundColour,
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
  Widget child = localImage(fullPath, imagePackage: imagePackage);
  if (imageBackgroundColour == null) return child;

  return Container(
    child: child,
    color: HexColor(imageBackgroundColour),
  );
}
