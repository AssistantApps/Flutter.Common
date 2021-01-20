class INavigationService {
  Future<bool> navigateBackOrHomeAsync(context) async {
    return Future.value(true);
  }

  Future<bool> navigateHomeAsync(context,
      {Function navigateTo,
      String navigateToNamed,
      bool pushReplacement}) async {
    return Future.value(false);
  }

  Future navigateAwayFromHomeAsync(
    context, {
    Function navigateTo,
    String navigateToNamed,
    Map<String, String> navigateToNamedParameters,
  }) async {}

  Future<T> navigateAsync<T extends Object>(context,
      {Function navigateTo, String navigateToNamed}) async {
    return Future.value(null);
  }
}
