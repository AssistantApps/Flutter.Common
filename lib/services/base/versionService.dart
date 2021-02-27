import 'package:package_info_plus/package_info_plus.dart';

import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';

class VersionService {
  Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
    bool hasPackageInfo = isAndroid || isiOS;
    if (!hasPackageInfo) {
      return ResultWithValue<PackageInfo>(
          false, PackageInfo(), 'platform not supported');
    }
    try {
      var packInfo = await PackageInfo.fromPlatform();
      return ResultWithValue<PackageInfo>(true, packInfo, '');
    } catch (exception) {
      return ResultWithValue<PackageInfo>(
          false, PackageInfo(), exception.toString());
    }
  }
}
