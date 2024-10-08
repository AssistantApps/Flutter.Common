import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart' show ObstructingPreferredSizeWidget;
import 'package:flutter/material.dart';

import '../../contracts/misc/action_item.dart';
import '../../integration/dependency_injection_base.dart';
import '../common/image.dart';
import '../common/text.dart';
import 'window_buttons.dart';

class WindowTitleBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final String title;
  final String iconPath;
  final List<ActionItem>? actions;
  @override
  final Size preferredSize;
  final dynamic bottom;
  final Color? backgroundColor;
  static const double kMinInteractiveDimensionCupertino = 44.0;

  WindowTitleBar({
    super.key,
    required this.title,
    required this.iconPath,
    this.bottom,
    this.backgroundColor,
    this.actions,
  }) : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        color: getTheme().getScaffoldBackgroundColour(context),
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: LocalImage(
                        imagePath: iconPath,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    GenericItemDescription(title),
                  ],
                ),
              ),
            ),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
