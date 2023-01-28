import 'package:flutter/material.dart';

import '../../constants/PaddingConstant.dart';
import '../../constants/UIConstants.dart';

class CommonCard extends StatelessWidget {
  final Widget imageWidget;
  final Widget bodyWidget;
  final void Function()? onTap;

  const CommonCard({
    Key? key,
    required this.imageWidget,
    required this.bodyWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapInCommonCard(
      onTap: onTap,
      child: Column(
        children: [
          imageWidget,
          Padding(
            padding: const EdgeInsets.all(16),
            child: bodyWidget,
          ),
        ],
      ),
    );
  }
}

class WrapInCommonCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;

  const WrapInCommonCard({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: PaddingConstant.commonCard,
          child: child,
        ),
      ),
    );
  }
}

class FlatCard extends StatelessWidget {
  final Widget child;
  final Color? shadowColor;

  const FlatCard({
    Key? key,
    required this.child,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      shape: UIConstants.noBorderRadius,
      shadowColor: shadowColor,
      child: child,
    );
  }
}
