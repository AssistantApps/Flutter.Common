import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide GuideApiService;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './constants/theme.dart';
import './services/theme_service.dart';
import './services/guideapi_service.dart';

class StorybookWrapper extends StatefulWidget {
  final AssistantAppsEnvironmentSettings env;
  final Widget? childWidget;
  const StorybookWrapper({
    Key? key,
    required this.env,
    required this.childWidget,
  }) : super(key: key);

  @override
  createState() => _StorybookWrapperState();
}

class _StorybookWrapperState extends State<StorybookWrapper> {
  _StorybookWrapperState();

  @override
  initState() {
    super.initState();
    initAssistantAppsDependencyInjection(
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, //provides localised strings
        GlobalWidgetsLocalizations.delegate, //provides RTL support
      ],
    );
  }
}
