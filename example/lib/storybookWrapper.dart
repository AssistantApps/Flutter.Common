import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide GuideApiService;
import 'package:flutter/material.dart';

import 'constants/theme.dart';
import 'services/themeService.dart';
import 'services/guideApiService.dart';

class StorybookWrapper extends StatefulWidget {
  final AssistantAppsEnvironmentSettings env;
  final Widget? childWidget;
  StorybookWrapper({
    required this.env,
    required this.childWidget,
  });

  @override
  _StorybookWrapperState createState() => _StorybookWrapperState();
}

class _StorybookWrapperState extends State<StorybookWrapper> {
  _StorybookWrapperState();

  @override
  initState() {
    super.initState();
    initBaseDependencyInjection(
      widget.env,
      theme: StorybookThemeService(),
      guideApi: GuideApiService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AssistantApps Storybook',
      home: widget.childWidget ?? Container(color: Colors.red),
      theme: darkTheme(),
    );
  }
}
