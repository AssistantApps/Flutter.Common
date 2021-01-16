import 'interface/ILoggingService.dart';

class LoggerService implements ILoggerService {
  @override
  void v(String message) {
    print('🔊 VERBOSE - $message----');
  }

  @override
  void i(String message) {
    print('❔ INFO - $message----');
  }

  @override
  void d(String message) {
    print('🐛 DEBUG - $message----');
  }

  @override
  void e(String message) {
    print('❌ ERROR - $message----');
  }
}
