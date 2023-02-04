import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../constants/app_duration.dart';
import '../../constants/modal.dart';
import '../../integration/talker.dart';

class LogsModalBottomSheet extends StatelessWidget {
  final String title;

  const LogsModalBottomSheet({Key? key, this.title = 'Logs'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppDuration.modal,
      child: Container(
        constraints: logsModalFullHeightSize(context),
        child: TalkerScreen(
          talker: talkerInstance,
          appBarTitle: title,
        ),
      ),
    );
  }
}
