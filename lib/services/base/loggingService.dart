import 'interface/ILoggingService.dart';

class LoggerService implements ILoggerService {
  @override
  void d(String message) {
    print('🐛 DEBUG - $message----');
  }

  @override
  void e(String message) {
    print('❌ ERROR - $message----');
  }
}
