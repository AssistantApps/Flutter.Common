import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../constants/AppDuration.dart';
import '../../constants/Modal.dart';

class LogsModalBottomSheet extends StatelessWidget {
  final String title;

  const LogsModalBottomSheet({Key? key, this.title = 'Logs'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppDuration.modal,
      child: Container(
        constraints: modalFullHeightSize(context),
        child: TalkerScreen(
          talker: Talker.instance,
          options: TalkerScreenOptions(appBarTitle: title),
        ),
      ),
    );
  }
}
