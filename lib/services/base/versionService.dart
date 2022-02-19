import 'package:package_info_plus/package_info_plus.dart';

import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';

class VersionService {
  Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
    PackageInfo defaultResult =
        PackageInfo(appName: '', buildNumber: '', packageName: '', version: '');

    bool hasPackageInfo = isAndroid || isiOS;
    if (!hasPackageInfo) {
      return ResultWithValue<PackageInfo>(
          false, defaultResult, 'platform not supported');
    }
    try {
      var packInfo = await PackageInfo.fromPlatform();
      return ResultWithValue<PackageInfo>(true, packInfo, '');
    } catch (exception) {
      return ResultWithValue<PackageInfo>(
          false, defaultResult, exception.toString());
    }
  }
}
