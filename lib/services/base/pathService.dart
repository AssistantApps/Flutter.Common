import 'package:assistantapps_flutter_common/components/common/image.dart';
import 'package:assistantapps_flutter_common/constants/UIConstants.dart';
import 'package:flutter/cupertino.dart';

import 'interface/IPathService.dart';

class PathService implements IPathService {
  String get imageAssetPathPrefix => 'assets/images';
  Widget get steamNewsDefaultImage => localImage(
        '$imageAssetPathPrefix/defaultSteamNews.jpg',
        imagePackage: UIConstants.CommonPackage,
      );
  String get defaultProfilePic => '';
  String get unknownImagePath => '';
}
