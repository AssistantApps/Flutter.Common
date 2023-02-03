import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../contracts/enum/locale_key.dart';
import '../../contracts/enum/platform_type.dart';
import '../../contracts/generated/version_view_model.dart';
import '../../contracts/misc/version_detail.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../integration/dependencyInjection.dart';
import './interface/IUpdateService.dart';

class UpdateService implements IUpdateService {
  //
  @override
  Future<void> checkForUpdate(BuildContext context, String externalUrl) async {
    if (getEnv().isProduction == false) return;
    ResultWithValue<bool> isOutdatedResult = await isOutdatedVersionCheck();

    bool isUpToDate = !isOutdatedResult.value;
    if (isOutdatedResult.hasFailed || isUpToDate) return;
    getLog().i('Update available');
    // ignore: use_build_context_synchronously
    showUpdateSnackbar(context, externalUrl);
  }

  @override
  Future<ResultWithValue<bool>> isOutdatedVersionCheck() async {
    ResultWithValue<VersionDetail> versionResult = await getPackageInfo();
    if (versionResult.hasFailed) {
      getLog().d(
          'Could not get version number from app. ${versionResult.errorMessage}');
      return ResultWithValue<bool>(false, false, versionResult.errorMessage);
    }

    List<PlatformType> platforms = getPlatforms();
    ResultWithValue<VersionViewModel> serverVersionResult =
        await getAssistantAppsVersions().getLatest(platforms);
    if (serverVersionResult.hasFailed) {
      return ResultWithValue<bool>(
          false, false, serverVersionResult.errorMessage);
    }

    try {
      String versionNumber = versionResult.value.version;
      getLog().i('Local versionNumber: $versionNumber');

      String localBuildNumber = versionResult.value.buildNumber;
      getLog().i('Local buildNumber: $localBuildNumber');

      int serverBuildNumber = serverVersionResult.value.buildNumber;
      getLog().i('Server buildNumber: $serverBuildNumber');

      int buildNumberOverride = getEnv().appVersionBuildNumberOverride ?? 0;
      if (buildNumberOverride > 0) {
        localBuildNumber = buildNumberOverride.toString();
        getLog().i('Overridden local buildNumber: $localBuildNumber');
      }

      if (serverBuildNumber > int.parse(localBuildNumber)) {
        return ResultWithValue<bool>(true, true, 'Outdated');
      }

      return ResultWithValue<bool>(true, false, 'Up to date');
    } catch (exception) {
      getLog().e("versionCheck Exception: ${exception.toString()}");
      return ResultWithValue<bool>(false, false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<VersionDetail>> getPackageInfo() async {
    VersionDetail result = VersionDetail(
      buildNumber: '',
      packageName: '',
      version: '',
    );
    //
    ResultWithValue<PackageInfo> versionResult = await currentAppVersion();
    if (versionResult.hasFailed) {
      getLog().d(
        'Could not get version number from app. ${versionResult.errorMessage}',
      );
      return ResultWithValue<VersionDetail>(
        false,
        result,
        versionResult.errorMessage,
      );
    }

    result.buildNumber = versionResult.value.buildNumber;
    result.packageName = versionResult.value.packageName;
    result.version = versionResult.value.version;

    if (getEnv().appVersionBuildNameOverride != null) {
      result.version = getEnv().appVersionBuildNameOverride!;
    }

    return ResultWithValue<VersionDetail>(true, result, '');
  }

  Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
    PackageInfo defaultResult = PackageInfo(
      appName: '',
      buildNumber: '',
      packageName: '',
      version: '',
    );

    try {
      PackageInfo packInfo = await PackageInfo.fromPlatform();
      return ResultWithValue<PackageInfo>(true, packInfo, '');
    } catch (exception) {
      return ResultWithValue<PackageInfo>(
          false, defaultResult, exception.toString());
    }
  }

  void showUpdateSnackbar(BuildContext snackCtx, String externalUrl) {
    LocaleKey storeLocale = LocaleKey.appStore;

    if (isAndroid) {
      storeLocale = LocaleKey.googlePlay;
    }

    getSnackbar().showSnackbar(
      snackCtx,
      LocaleKey.updateAvailable,
      duration: const Duration(minutes: 5),
      onPositive: () => launchExternalURL(externalUrl),
      onPositiveText: getTranslations().fromKey(storeLocale),
    );
  }
}
