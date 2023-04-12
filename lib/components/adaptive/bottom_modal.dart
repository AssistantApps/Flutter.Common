import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

void adaptiveBottomModalSheet(
  BuildContext context, {
  required Widget Function(BuildContext) builder,
  bool hasRoundedCorners = false,
  bool isScrollControlled = false,
  BoxConstraints? constraints,
}) {
  showModalBottomSheet<void>(
    context: context,
    constraints: constraints,
    isScrollControlled: isScrollControlled,
    builder: (innerContext) => builder(innerContext),
    shape: hasRoundedCorners
        ? const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          )
        : null,
  );
}

void adaptiveListBottomModalSheet(
  BuildContext context, {
  required Widget Function(BuildContext, ScrollController) builder,
  bool hasRoundedCorners = false,
  BoxConstraints? constraints,
}) {
  double initialChildSize = 0.6;
  double maxChildSize = 0.95;
  if (constraints != null) {
    initialChildSize =
        constraints.minHeight / MediaQuery.of(context).size.height;
  }
  showModalBottomSheet<void>(
    context: context,
    constraints: constraints,
    isScrollControlled: true,
    backgroundColor: getTheme().getScaffoldBackgroundColour(context),
    shape: hasRoundedCorners
        ? const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          )
        : null,
    builder: (innerContext) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialChildSize,
      minChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext dragCtx, ScrollController scrollController) {
        return builder(dragCtx, scrollController);
      },
    ),
  );
}
