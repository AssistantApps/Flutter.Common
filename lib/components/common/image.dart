import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_image.dart';
import '../../constants/ui_constants.dart';
import '../../helpers/device_helper.dart';
import '../../helpers/path_helper.dart';
import '../../integration/dependencyInjection.dart';

class ImageFromNetwork extends StatelessWidget {
  final String imageUrl;
  final BoxFit? boxfit;
  final double? height;
  final double? width;
  final Widget? loading;

  const ImageFromNetwork({
    Key? key,
    required this.imageUrl,
    this.boxfit,
    this.height,
    this.width,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget Function() getImgWidget = () {
      return OctoImage(
        image: CachedNetworkImageProvider(
          imageUrl,
          // imageRenderMethodForWeb: isWeb
          //     ? ImageRenderMethodForWeb.HttpGet
          //     : ImageRenderMethodForWeb.HtmlImage,
        ),
        placeholderBuilder: (BuildContext context) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(12),
            child: loading ?? getLoading().smallLoadingIndicator(),
          ));
        },
        errorBuilder: OctoError.icon(color: Colors.red),
        fit: boxfit,
        height: height,
        width: width,
      );
    };

    if (isWeb) {
      getImgWidget = () => Image.network(
            imageUrl,
            fit: boxfit,
            height: height,
            width: width,
          );
    }

    if (imageUrl.contains('.svg')) {
      getImgWidget = () => SizedBox(
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
}

class LocalImage extends StatelessWidget {
  final String imagePath;
  final String? imageHero;
  final String? imagePackage;
  final BoxFit? boxfit;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;

  const LocalImage({
    Key? key,
    required this.imagePath,
    this.imageHero,
    this.imagePackage,
    this.boxfit,
    this.height,
    this.width,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      getImagePath(imagePath, imagePackage: imagePackage),
      package: imagePackage,
      fit: boxfit,
      height: height,
      width: width,
    );

    Widget imgWidget = (imageHero != null)
        ? Hero(tag: imageHero!, child: image) //
        : image;

    if (borderRadius != null) {
      return Padding(
        padding: padding,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: imgWidget,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: imgWidget,
    );
  }
}

class CorrectlySizedImageFromIcon extends StatelessWidget {
  final IconData icon;
  final Color? colour;
  final double maxSize;

  const CorrectlySizedImageFromIcon({
    Key? key,
    required this.icon,
    this.colour,
    this.maxSize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
  }
}

class ListTileImage extends StatelessWidget {
  final String partialPath;
  final double size;
  final EdgeInsets? padding;
  final String? package;

  const ListTileImage({
    Key? key,
    required this.partialPath,
    this.size = 35,
    this.padding,
    this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstrainedBox child = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size,
        maxHeight: size,
      ),
      child: LocalImage(imagePath: partialPath, imagePackage: package),
    );
    if (padding == null) return child;
    return Padding(padding: padding!, child: child);
  }
}

class NetworkBlurHashImage extends StatelessWidget {
  final String imageUrl;
  final String blurHash;
  final BoxFit? boxfit;
  final double? height;
  final double? width;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final void Function()? onTap;

  const NetworkBlurHashImage({
    Key? key,
    required this.imageUrl,
    required this.blurHash,
    this.boxfit,
    this.height,
    this.width,
    this.placeHolder,
    this.errorWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      child: SizedBox(
        height: height,
        width: width,
        child: OctoImage(
          fit: boxfit,
          image: CachedNetworkImageProvider(
            (imageUrl.contains('http'))
                ? imageUrl
                : getPath().defaultProfilePic,
          ),
          placeholderBuilder: OctoPlaceholder.blurHash(blurHash),
          errorBuilder: (_, __, ___) =>
              errorWidget ??
              LocalImage(
                imagePath: AppImage.error,
                imagePackage: UIConstants.commonPackage,
                width: width ?? 150,
                height: height ?? 150,
              ),
          // progressIndicatorBuilder: (_, __) => smallLoadingIndicator(),
        ),
      ),
      onTap: () {
        if (onTap == null) return;
        onTap!();
      },
    );
  }
}

Image getCountryFlag(String countryCode) {
  return Image.asset(
    'icons/flags/png/$countryCode.png',
    package: 'country_icons',
  );
}
