import 'package:flutter/material.dart';

class AdaptiveAppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget Function(BuildContext scaffoldContext)? builder;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AdaptiveAppScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.builder,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? customBody = (builder != null) //
        ? Builder(builder: (inner) => builder!(inner))
        : body;

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
}
