import 'package:assistantapps_flutter_common/components/common/image.dart';
import 'package:assistantapps_flutter_common/constants/UIConstants.dart';
import 'package:flutter/cupertino.dart';

import './interface/IPathService.dart';

class PathService implements IPathService {
  @override
  String get imageAssetPathPrefix => 'assets/images';
  @override
  Widget get steamNewsDefaultImage => localImage(
        '$imageAssetPathPrefix/defaultSteamNews.jpg',
        imagePackage: UIConstants.CommonPackage,
      );
  @override
  String get defaultProfilePic => '';
  @override
  String get defaultGuideImage => 'assets/images/guide/noImage.png';
  @override
  String get unknownImagePath => '';
}
