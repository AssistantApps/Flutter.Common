import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/IUpdateService.dart';
import 'versionService.dart';

class UpdateService implements IUpdateService {
  Future<void> checkForUpdate(BuildContext context, String externalUrl) async {
    if (getEnv().isProduction == false) return;
    ResultWithValue<bool> isOutdatedResult =
        await this.isOutdatedVersionCheck();

    bool isUpToDate = !isOutdatedResult.value;
    if (isOutdatedResult.hasFailed || isUpToDate) return;
    getLog().i('Update available');
    this.showUpdateSnackbar(context, externalUrl);
  }

  Future<ResultWithValue<bool>> isOutdatedVersionCheck() async {
    ResultWithValue<PackageInfo> versionResult =
        await VersionService().currentAppVersion();
    if (versionResult.hasFailed) {
      getLog().d('Could not get version number from app. ' +
          versionResult.errorMessage);
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

  void showUpdateSnackbar(BuildContext context, String externalUrl) {
    LocaleKey storeLocale = LocaleKey.appStore;

    if (isAndroid) {
      storeLocale = LocaleKey.googlePlay;
    }

    getSnackbar().showSnackbar(
      context,
      LocaleKey.updateAvailable,
      duration: Duration(minutes: 5),
      onPositive: () => launchExternalURL(externalUrl),
      onPositiveText: getTranslations().fromKey(storeLocale),
    );
  }
}
