import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart' show ObstructingPreferredSizeWidget;
import 'package:flutter/material.dart';

import '../../contracts/misc/actionItem.dart';
import '../../integration/dependencyInjectionBase.dart';
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
    Key? key,
    required this.title,
    required this.iconPath,
    this.bottom,
    this.backgroundColor,
    this.actions,
  })  : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

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
