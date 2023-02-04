import 'package:get_it/get_it.dart';

void regBackup<T extends Object>(
  T? service,
  T? backupService, {
  String? instanceName,
}) {
  GetIt getIt = GetIt.instance;
  if (service != null) {
    getIt.registerSingleton<T>(service, instanceName: instanceName);
  } else if (backupService != null) {
    getIt.registerSingleton<T>(backupService, instanceName: instanceName);
  }
}
