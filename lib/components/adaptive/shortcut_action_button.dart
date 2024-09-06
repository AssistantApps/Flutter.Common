import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class ShortcutActionButton extends StatelessWidget {
  final List<ActionItem> actions;

  const ShortcutActionButton(
    this.actions, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (actions.length == 1) {
      return actionItemToAndroidAction(context, actions)[0];
    }
    return PopupMenuButton<void Function()?>(
      onSelected: (void Function()? func) {
        if (func != null) func();
      },
      icon: const Icon(Icons.link),
      itemBuilder: (BuildContext context) => actions
          .map((action) => PopupMenuItem<void Function()?>(
                value: action.onPressed,
                child: ShortcutPresenter(action),
              ))
          .toList(),
    );
  }
}

class ShortcutPresenter extends StatelessWidget {
  final ActionItem action;

  const ShortcutPresenter(
    this.action, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        action.image ?? Icon(action.icon),
        const SizedBox(width: 10),
        Text(
          action.text ?? '',
          style: TextStyle(
            color: getTheme().getIsDark(context) ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
