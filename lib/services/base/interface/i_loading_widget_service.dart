import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ILoadingWidgetService {
  Widget smallLoadingIndicator() => Container();

  Widget smallLoadingTile(BuildContext context, {String? loadingText}) =>
      Container();

  Widget loadingIndicator({double height = 50.0}) => Container();

  Widget fullPageLoading(BuildContext context, {String? loadingText}) =>
      Container();

  Widget customErrorWidget(BuildContext context, {String? text}) => Container();
}
