import 'package:assistantapps_flutter_common/components/common/image.dart';
import 'package:assistantapps_flutter_common/constants/ui_constants.dart';
import 'package:flutter/cupertino.dart';

import './interface/i_path_service.dart';

class PathService implements IPathService {
  @override
  String get imageAssetPathPrefix => 'assets/images';
  @override
  Widget get steamNewsDefaultImage => LocalImage(
        imagePath: '$imageAssetPathPrefix/defaultSteamNews.jpg',
        imagePackage: UIConstants.commonPackage,
      );
  @override
  String get defaultProfilePic => '';
  @override
  String get defaultGuideImage => 'assets/images/guide/noImage.png';
  @override
  String get unknownImagePath => '';
}
