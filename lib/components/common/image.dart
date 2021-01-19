import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

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
      image: CachedNetworkImageProvider(imageUrl),
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
  String package,
  BoxFit boxfit,
  double height,
  double width,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  var image = Image.asset(
    imagePath,
    package: package,
    fit: boxfit,
    height: height,
    width: width,
  );
  return Padding(
    child: image,
    padding: padding,
  );
}

Widget getCorrectlySizedImageFromIcon(context, IconData icon,
        {Color colour, double size = 35}) =>
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size,
        maxHeight: size,
      ),
      child: Center(
        child: Icon(
          icon,
          color: colour ?? getTheme().getSecondaryColour(context),
          size: size,
        ),
      ),
    );
