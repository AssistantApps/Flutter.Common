import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/common/image.dart';
import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/localeKey.dart';
import '../../helpers/deviceHelper.dart';
import '../../integration/dependencyInjection.dart';
import './interface/ILoadingWidgetService.dart';

class LoadingWidgetService implements ILoadingWidgetService {
  @override
  Widget smallLoadingIndicator() {
    return isApple ? CupertinoActivityIndicator() : CircularProgressIndicator();
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
        alignment: Alignment(0, 0),
        child: smallLoadingIndicator(),
        height: height,
      );

  @override
  Widget fullPageLoading(BuildContext context, {String? loadingText}) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              smallLoadingIndicator(),
            ], mainAxisAlignment: MainAxisAlignment.center),
            Row(children: <Widget>[
              Container(
                margin: EdgeInsets.all(12),
              )
            ], mainAxisAlignment: MainAxisAlignment.center),
            Row(children: <Widget>[
              Text(loadingText ?? getTranslations().fromKey(LocaleKey.loading))
            ], mainAxisAlignment: MainAxisAlignment.center),
          ],
        ),
      );

  @override
  Widget customErrorWidget(BuildContext context, {String? text}) {
    return Center(
      child: Column(
        children: [
          localImage(
            AppImage.error,
            width: 500,
            padding: EdgeInsets.all(8),
            imagePackage: UIConstants.CommonPackage,
          ),
          Text(
            text ?? getTranslations().fromKey(LocaleKey.somethingWentWrong),
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
