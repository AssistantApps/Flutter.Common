import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/common/image.dart';
import '../../constants/app_image.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/enum/locale_key.dart';
import '../../helpers/deviceHelper.dart';
import '../../integration/dependencyInjection.dart';
import './interface/ILoadingWidgetService.dart';

class LoadingWidgetService implements ILoadingWidgetService {
  @override
  Widget smallLoadingIndicator() {
    return isApple
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }

  @override
  Widget smallLoadingTile(BuildContext context, {String? loadingText}) =>
      ListTile(
        leading: smallLoadingIndicator(),
        title:
            Text(loadingText ?? getTranslations().fromKey(LocaleKey.loading)),
      );

  @override
  Widget loadingIndicator({double height = 50.0}) => Container(
        alignment: const Alignment(0, 0),
        height: height,
        child: smallLoadingIndicator(),
      );

  @override
  Widget fullPageLoading(BuildContext context, {String? loadingText}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            smallLoadingIndicator(),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              margin: const EdgeInsets.all(12),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(loadingText ?? getTranslations().fromKey(LocaleKey.loading))
          ]),
        ],
      );

  @override
  Widget customErrorWidget(BuildContext context, {String? text}) {
    return Center(
      child: Column(
        children: [
          const LocalImage(
            imagePath: AppImage.error,
            width: 500,
            padding: EdgeInsets.all(8),
            imagePackage: UIConstants.commonPackage,
          ),
          Text(
            text ?? getTranslations().fromKey(LocaleKey.somethingWentWrong),
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
