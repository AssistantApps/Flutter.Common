import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

class PlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;

  const PlaceholderImage({
    Key? key,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100,
      height: height ?? 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 4, right: 4, bottom: 4),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          dashPattern: const [8, 4],
          color: getTheme().getSecondaryColour(context),
          child: InkWell(
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Center(
                child: Icon(Icons.image, size: 50),
              ),
            ),
            onTap: () {
              if (onTap == null) return;
              onTap!();
            },
          ),
        ),
      ),
    );
  }
}

class PlaceholderFullRow extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;

  const PlaceholderFullRow({
    Key? key,
    this.width,
    this.height,
    this.icon,
    this.padding = EdgeInsets.zero,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 4, right: 4, bottom: 4),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          dashPattern: const [8, 4],
          color: getTheme().getSecondaryColour(context),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Center(
              child: SizedBox(
                width: width ?? 75,
                height: height ?? 75,
                child: Center(child: Icon(icon, size: 50)),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        if (onTap == null) return;
        onTap!();
      },
    );
  }
}
