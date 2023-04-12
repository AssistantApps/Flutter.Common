import 'package:flutter/material.dart';

import '../../constants/app_duration.dart';
import '../../constants/modal.dart';
import '../../pages/misc/logs_view_page.dart';

class LogsModalBottomSheet extends StatelessWidget {
  final String title;

  const LogsModalBottomSheet({Key? key, this.title = 'Logs'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppDuration.modal,
      child: Container(
        constraints: logsModalFullHeightSize(context),
        child: LogsViewPage(title: title),
      ),
    );
  }
}
