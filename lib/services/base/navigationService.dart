import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';
import 'interface/INavigationService.dart';

class NavigationService implements INavigationService {
  @override
  Future<bool> navigateBackOrHomeAsync(context) async {
    const baseLogMsg = 'navigationService - navigateBackOrHomeAsync';
    getLog().i(baseLogMsg);
    if (Navigator.canPop(context)) {
      getLog().i('$baseLogMsg - canPop');
      Navigator.pop(context);
      return Future.value(false);
    }

    // await Navigator.pushReplacementNamed(context, Routes.home);

    return Future.value(true);
  }

  @override
  Future<bool> navigateHomeAsync(context,
      {Widget Function(BuildContext)? navigateTo,
      String? navigateToNamed,
      bool? pushReplacement}) async {
    const baseLogMsg = 'navigationService - navigateHomeAsync';
    getLog().i(baseLogMsg);
    Navigator.popUntil(context, (r) => !Navigator.canPop(context));

    if (navigateTo != null) {
      // await Navigator.pushReplacement(
      getLog().i('$baseLogMsg - navigateTo !- null');
      await Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else if (navigateToNamed != null) {
      getLog().i('$baseLogMsg - navigateToName != null');
      if (pushReplacement != null && pushReplacement == true) {
        getLog().i('$baseLogMsg - pushReplacementNamed');
        await Navigator.pushReplacementNamed(
          context,
          navigateToNamed,
        );
      } else {
        getLog().i('$baseLogMsg - pushNamed');
        await Navigator.pushNamed(
          context,
          navigateToNamed,
        );
      }
    }

    return Future.value(false);
  }

  @override
  Future navigateAwayFromHomeAsync(
    context, {
    Widget Function(BuildContext)? navigateTo,
    String? navigateToNamed,
    Map<String, String>? navigateToNamedParameters,
  }) async {
    const baseLogMsg = 'navigationService - navigateAwayFromHomeAsync';
    getLog().i(baseLogMsg);
    if (navigateTo != null) {
      getLog().i('$baseLogMsg - navigateTo != null');
      Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else if (navigateToNamed != null) {
      getLog().i('$baseLogMsg - navigateToNamed != null');
      // Navigator.pushReplacementNamed(
      Navigator.pushNamed(
        context,
        navigateToNamed,
      );
    }
  }

  @override
  Future<T?> navigateAsync<T extends Object>(context,
      {Widget Function(BuildContext)? navigateTo,
      String? navigateToNamed}) async {
    const baseLogMsg = 'navigationService - navigateAsync';
    getLog().i(baseLogMsg);
    if (navigateTo != null) {
      getLog().i('$baseLogMsg - navigateTo != null');
      return await Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else if (navigateToNamed != null) {
      getLog().i('$baseLogMsg - navigateToNamed != null');
      return await Navigator.pushNamed(
        context,
        navigateToNamed,
      );
    }
    return null;
  }

  @override
  Future pop<T extends Object>(BuildContext context, [T? result]) async {
    getLog().i('navigationService - pop');
    Navigator.of(context).pop(result);
  }
}
