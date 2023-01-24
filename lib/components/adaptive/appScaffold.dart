import 'package:flutter/material.dart';

Widget adaptiveAppScaffold(
  BuildContext context, {
  PreferredSizeWidget? appBar,
  Widget? body,
  Widget Function(BuildContext scaffoldContext)? builder,
  Widget? drawer,
  Widget? bottomNavigationBar,
  Widget? floatingActionButton,
  FloatingActionButtonLocation? floatingActionButtonLocation,
}) {
  Widget? customBody =
      builder != null ? Builder(builder: (inner) => builder(inner)) : body;

  return Scaffold(
    key: const Key('homeScaffold'),
    appBar: appBar,
    body: customBody,
    drawer: drawer,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
  );
}
