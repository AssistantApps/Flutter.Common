import 'package:flutter/material.dart';

class INavigationService {
  Future<bool> navigateBackOrHomeAsync(BuildContext context) async {
    return Future.value(true);
  }

  Future<bool> navigateHomeAsync(
    BuildContext context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
    bool? pushReplacement,
  }) async {
    return Future.value(false);
  }

  Future navigateAwayFromHomeAsync(
    BuildContext context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
    Map<String, String>? navigateToNamedParameters,
  }) async {}

  Future<T?> navigateAsync<T extends Object>(
    context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
  }) async {
    return Future.value(null);
  }

  Future pop<T extends Object>(BuildContext context, [T? result]) async {}

  Future popUntil(BuildContext context, List<String> routes) async {}
}
