import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/storybook_names.dart';

List<Story> getHomeStories() {
  return [
    Story(
      name: StorybookNames.welcome,
      description: 'Quick intro to this site',
      builder: (context) => getBaseWidget().appScaffold(
        context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          showBackAction: false,
          title: const Text('Welcome!'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              EmptySpace2x(),
              Text(
                'Welcome to the Storybook page of the AssistantApps common library',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  ];
}
