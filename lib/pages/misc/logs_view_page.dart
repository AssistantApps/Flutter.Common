import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../integration/talker.dart';

class LogsViewPage extends StatelessWidget {
  final String title;

  const LogsViewPage({super.key, this.title = 'Logs'});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: talkerInstance,
      appBarTitle: title,
    );
  }
}
