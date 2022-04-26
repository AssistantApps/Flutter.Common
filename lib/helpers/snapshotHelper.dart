import 'package:flutter/material.dart';

import '../contracts/enum/localeKey.dart';
import '../integration/dependencyInjection.dart';

Widget? asyncSnapshotHandler<T>(
  BuildContext context,
  AsyncSnapshot<T> snapshot, {
  bool Function(T?)? isValidFunction,
  Widget Function()? invalidBuilder,
  Widget Function()? loader,
}) {
  Widget errorWidget = getLoading().customErrorWidget(context);
  switch (snapshot.connectionState) {
    case ConnectionState.none:
      return errorWidget;
    case ConnectionState.done:
      if (snapshot.hasError) {
        return errorWidget;
      }
      break;
    default:
      if (loader != null) return loader();
      return getLoading().fullPageLoading(
        context,
        loadingText: getTranslations().fromKey(LocaleKey.loading),
      );
  }

  if (snapshot.data == null) return errorWidget;
  if (isValidFunction != null && !isValidFunction(snapshot.data)) {
    if (invalidBuilder != null) return invalidBuilder();
    return errorWidget;
  }

  return null;
}
