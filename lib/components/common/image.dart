import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../helpers/pathHelper.dart';
import '../../integration/dependencyInjection.dart';

Widget networkImage(
  String imageUrl, {
  BoxFit? boxfit,
  double? height,
  double? width,
  Widget? loading,
}) {
  Widget Function() getImgWidget = () {
    return OctoImage(
      image: CachedNetworkImageProvider(
        imageUrl,
        // TODO uncomment this... No you
        // imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
      ),
      placeholderBuilder: (BuildContext context) {
        return Center(
            child: Padding(
          child: loading ?? getLoading().smallLoadingIndicator(),
          padding: EdgeInsets.all(12),
        ));
      },
      errorBuilder: OctoError.icon(color: Colors.red),
      fit: boxfit,
      height: height,
      width: width,
    );
  };

  if (imageUrl.contains('.svg')) {
    getImgWidget = () => Container(
          height: height,
          width: width,
          child: SvgPicture.network(
            imageUrl,
            height: height,
            width: width,
            fit: boxfit ?? BoxFit.contain,
          ),
        );
  }

  return SizedBox(
    height: height,
    width: width,
    child: getImgWidget(),
  );
}

Widget localImage(
  String imagePath, {
  String? imageHero,
  String? imagePackage,
  BoxFit? boxfit,
  double? height,
  double? width,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  Image image = Image.asset(
    getImagePath(imagePath, imagePackage: imagePackage),
    package: imagePackage,
    fit: boxfit,
    height: height,
    width: width,
  );

  Widget imgWidget = (imageHero != null)
      ? Hero(tag: imageHero, child: image) //
      : image;

  if (borderRadius != null) {
    return Padding(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: imgWidget,
      ),
      padding: padding,
    );
  }

  return Padding(
    child: imgWidget,
    padding: padding,
  );
}

Widget getCorrectlySizedImageFromIcon(
  context,
  IconData icon, {
  Color? colour,
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
  EdgeInsets? padding,
  String? package,
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

Widget networkBlurHashImage(
  String imageUrl,
  String blurHash, {
  Key? key,
  BoxFit? boxfit,
  double? height,
  double? width,
  Widget? placeHolder,
  Widget? errorWidget,
  void Function()? onTap,
}) {
  return InkWell(
    key: key,
    child: SizedBox(
      height: height,
      width: width,
      child: OctoImage(
        fit: boxfit,
        image: CachedNetworkImageProvider(
          (imageUrl.contains('http')) ? imageUrl : getPath().defaultProfilePic,
        ),
        placeholderBuilder: OctoPlaceholder.blurHash(blurHash),
        errorBuilder: (_, __, ___) =>
            errorWidget ??
            localImage(
              AppImage.error,
              imagePackage: UIConstants.CommonPackage,
              width: width ?? 150,
              height: height ?? 150,
            ),
        // progressIndicatorBuilder: (_, __) => smallLoadingIndicator(),
      ),
    ),
    onTap: () {
      if (onTap != null) onTap();
    },
  );
}

Image getCountryFlag(String countryCode) {
  return Image.asset(
    'icons/flags/png/$countryCode.png',
    package: 'country_icons',
  );
}
