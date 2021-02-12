import 'package:flutter/material.dart';

Widget adaptiveAppScaffold(
  BuildContext context, {
  @required Widget appBar,
  Widget body,
  Widget Function(BuildContext scaffoldContext) builder,
  Widget drawer,
  Widget bottomNavigationBar,
  Widget floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation,
}) {
  Widget deviceAppBar = appBar != null ? appBar : null;
  Widget customBody =
      builder != null ? Builder(builder: (inner) => builder(inner)) : body;

  return Scaffold(
    key: Key('homeScaffold'),
    appBar: deviceAppBar,
    body: customBody,
    drawer: drawer,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
  );
}
