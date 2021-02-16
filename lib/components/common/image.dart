import 'package:assistantapps_flutter_common/helpers/pathHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../../assistantapps_flutter_common.dart';
import '../../integration/dependencyInjection.dart';

Widget networkImage(
  String imageUrl, {
  BoxFit boxfit,
  double height,
  double width,
  Widget loading,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: OctoImage(
      image: CachedNetworkImageProvider(
        imageUrl,
        imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
      ),
      placeholderBuilder: (BuildContext context) {
        return Center(
            child: Padding(
          child: loading ?? CircularProgressIndicator(),
          padding: EdgeInsets.all(12),
        ));
      },
      errorBuilder: OctoError.icon(color: Colors.red),
      fit: boxfit,
      height: height,
      width: width,
    ),
  );
}

Widget localImage(
  String imagePath, {
  String imagePackage,
  BoxFit boxfit,
  double height,
  double width,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  Image image = Image.asset(
    getImagePath(imagePath, imagePackage: imagePackage),
    package: imagePackage,
    fit: boxfit,
    height: height,
    width: width,
  );
  return Padding(
    child: image,
    padding: padding,
  );
}

Widget getCorrectlySizedImageFromIcon(
  context,
  IconData icon, {
  Color colour,
  double maxSize = 35,
}) =>
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxSize,
        maxHeight: maxSize,
      ),
      child: Center(
        child: Icon(
          icon,
          color: colour ?? getTheme().getSecondaryColour(context),
          size: maxSize,
        ),
      ),
    );

Widget getListTileImage(
  String partialPath, {
  double size = 35,
  EdgeInsets padding,
  String package,
}) {
  ConstrainedBox child = ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: size,
      maxHeight: size,
    ),
    child: localImage(partialPath, imagePackage: package),
  );
  if (padding == null) return child;
  return Padding(padding: padding, child: child);
}
