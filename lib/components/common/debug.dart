import 'package:assistantapps_flutter_common/integration/dependency_injection.dart';
import 'package:flutter/material.dart';

import '../../helpers/external_helper.dart';

List<Widget> getDebugDetails() {
  List<Widget> widgets = List.empty(growable: true);

  String buildNum = getEnv().buildNum ?? '';
  String buildName = getEnv().buildName ?? '';
  String commitHash = getEnv().commitHash ?? '';
  String githubViewAppRepoAtCommit = getEnv().githubViewAppRepoAtCommit ?? '';

  if (buildNum.isNotEmpty) {
    widgets.add(Center(child: Text('BuildNum: ${getEnv().buildNum}')));
  }

  if (buildName.isNotEmpty) {
    widgets.add(Center(child: Text('BuildName: ${getEnv().buildName}')));
  }

  if (commitHash.isNotEmpty && githubViewAppRepoAtCommit.isNotEmpty) {
    widgets.add(Center(
      child: GestureDetector(
        child: Text(
          'BuildName: ${getEnv().commitHash}',
          maxLines: 3,
          style: const TextStyle(color: Colors.blue),
        ),
        onTap: () => launchExternalURL(
          githubViewAppRepoAtCommit + commitHash,
        ),
      ),
    ));
  }

  return widgets;
}
