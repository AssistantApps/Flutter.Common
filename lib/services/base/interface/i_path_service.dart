import 'package:flutter/material.dart';

abstract class IPathService {
  String get imageAssetPathPrefix => '';
  Widget get steamNewsDefaultImage => Container();
  String get defaultProfilePic => '';
  String get defaultGuideImage => '';
  String get unknownImagePath => '';
  String ofImage(String imagePartialPath) => '';
}
