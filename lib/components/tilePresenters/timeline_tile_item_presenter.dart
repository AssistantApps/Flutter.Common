import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../integration/dependency_injection.dart';

Widget timelineTilePresenter(
  BuildContext context,
  Widget contents, {
  IconData? customIndicatorIcon,
  Widget? oppositeContents,
  bool? hideTopConnector,
  bool? hideBottomConnector,
  Color? lineColour,
  Color? iconColour,
}) {
  return TimelineTile(
    contents: contents,
    nodeAlign: TimelineNodeAlign.start,
    node: TimelineNode.simple(
      indicatorChild: DotIndicator(
        color: lineColour ?? getTheme().getSecondaryColour(context),
        child: (customIndicatorIcon == null)
            ? null
            : Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  customIndicatorIcon,
                  color: iconColour ?? Colors.black,
                ),
              ),
      ),
      drawStartConnector: (hideTopConnector != true),
      drawEndConnector: (hideBottomConnector != true),
      color: getTheme().getSecondaryColour(context),
    ),
  );
}
