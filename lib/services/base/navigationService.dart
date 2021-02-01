import 'package:flutter/material.dart';

import 'interface/INavigationService.dart';

class NavigationService implements INavigationService {
  @override
  Future<bool> navigateBackOrHomeAsync(context) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return Future.value(false);
    }

    // await Navigator.pushReplacementNamed(context, Routes.home);

    return Future.value(true);
  }

  @override
  Future<bool> navigateHomeAsync(context,
      {Function navigateTo,
      String navigateToNamed,
      bool pushReplacement}) async {
    Navigator.popUntil(context, (r) => !Navigator.canPop(context));

    if (navigateTo != null) {
      // await Navigator.pushReplacement(
      await Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else if (navigateToNamed != null) {
      if (pushReplacement != null && pushReplacement == true) {
        await Navigator.pushReplacementNamed(
          context,
          navigateToNamed,
        );
      } else {
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
    Function navigateTo,
    String navigateToNamed,
    Map<String, String> navigateToNamedParameters,
  }) async {
    if (navigateTo != null) {
      if (Navigator.canPop(context)) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: navigateTo),
        );
      } else {
        // Navigator.pushReplacement(
        Navigator.push(
          context,
          MaterialPageRoute(builder: navigateTo),
        );
      }
    } else {
      // Navigator.pushReplacementNamed(
      Navigator.pushNamed(
        context,
        navigateToNamed,
      );
    }
  }

  @override
  Future<T> navigateAsync<T extends Object>(context,
      {Function navigateTo, String navigateToNamed}) async {
    if (navigateTo != null) {
      return await Navigator.push(
        context,
        MaterialPageRoute(builder: navigateTo),
      );
    } else {
      return await Navigator.pushNamed(
        context,
        navigateToNamed,
      );
    }
  }

  @override
  Future pop<T extends Object>(BuildContext context, [T result]) async {
    Navigator.of(context).pop(result);
  }
}
