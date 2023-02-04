import 'package:assistantapps_flutter_common/constants/signal_r_events.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../contracts/results/result.dart';
import '../integration/dependency_injection.dart';

class BaseSignalRService {
  final String _baseUrl;
  HubConnection? _hubConnection;
  BaseSignalRService(this._baseUrl);

  Future<Result> createConnection(
    void Function({Exception? error}) onClose,
  ) async {
    getLog().d('Connecting to: $_baseUrl');
    try {
      _hubConnection = HubConnectionBuilder().withUrl(_baseUrl).build();
      _hubConnection?.onclose(onClose);
      await _hubConnection?.start();
    } catch (exception) {
      getLog().e('CreateConnection Exception: ${exception.toString()}');
      return Result(false, exception.toString());
    }
    getLog().d('Successfully connected to: $_baseUrl');
    return Result(true, '');
  }

  bool get isConnected =>
      _hubConnection != null &&
      _hubConnection?.state == HubConnectionState.Connected;

  void addListener(
      SignalRReceiveEvent event, void Function(List<Object?>?) onFunc) async {
    getLog().d('Listening for: ${EnumToString.convertToString(event)}');
    if (!isConnected) return;

    try {
      _hubConnection?.on(EnumToString.convertToString(event), onFunc);
    } catch (exception) {
      getLog().e(
        'Failed to add listener for: ${EnumToString.convertToString(event)}. Ex: ${exception.toString()}',
      );
    }
  }

  void removeListener(SignalRReceiveEvent event) async {
    getLog().d('Un-Listening to: ${EnumToString.convertToString(event)}');
    if (!isConnected) return;

    try {
      _hubConnection?.off(EnumToString.convertToString(event));
    } catch (exception) {
      getLog().e(
        'Failed to remove listener for: ${EnumToString.convertToString(event)}. Ex: ${exception.toString()}',
      );
    }
  }

  void sendPayload(SignalRSendEvent event, List<Object> payload) async {
    getLog().d('Sending event ${EnumToString.convertToString(event)}');
    if (!isConnected) return;

    try {
      await _hubConnection?.invoke(EnumToString.convertToString(event),
          args: payload);
    } catch (exception) {
      getLog().e(
        'Failed to send for: ${EnumToString.convertToString(event)}. Ex: ${exception.toString()}',
      );
    }
  }

  Future<Result> closeConnection() async {
    getLog().d('Closing connecting to: $_baseUrl');
    if (!isConnected) return Result(false, 'Already closed');
    try {
      await _hubConnection?.stop();
      return Result(true, '');
    } catch (exception) {
      getLog().e('closingConnection Exception: ${exception.toString()}');
      return Result(false, exception.toString());
    }
  }
}
