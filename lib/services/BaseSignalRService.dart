import 'package:signalr_netcore/signalr_client.dart';

import '../contracts/results/result.dart';
import '../integration/dependencyInjection.dart';

class BaseSignalRService {
  String _baseUrl;
  HubConnection _hubConnection;
  BaseSignalRService(String baseUrl) {
    this._baseUrl = baseUrl;
    getLog().d('BaseSignalRService ctor: $baseUrl');
    this._hubConnection = HubConnectionBuilder().withUrl(_baseUrl).build();
  }

  Future<Result> createConnection(
    void Function({Exception error}) onClose,
  ) async {
    getLog().d('Connecting to: $_baseUrl');
    try {
      this._hubConnection.onclose(onClose);
      await this._hubConnection.start();
    } catch (exception) {
      getLog().e('CreateConnection Exception: ${exception.toString()}');
      return Result(false, exception.toString());
    }
    getLog().d('Successfully connected to: $_baseUrl');
    return Result(true, '');
  }

  bool get isConnected =>
      this._hubConnection == null &&
      this._hubConnection.state != HubConnectionState.Connected;

  void addListener(String event, void Function(List<Object>) onFunc) async {
    getLog().d('Listening for: $event');
    if (!isConnected) return;

    try {
      this._hubConnection.on(event, onFunc);
    } catch (exception) {
      getLog().e(
        'Failed to add listener for: $event. Ex: ${exception.toString()}',
      );
    }
  }

  void removeListener(String event) async {
    getLog().d('Un-Listening to: $event');
    if (!isConnected) return;

    try {
      this._hubConnection.off(event);
    } catch (exception) {
      getLog().e(
        'Failed to remove listener for: $event. Ex: ${exception.toString()}',
      );
    }
  }

  void sendPayload(String event, List<Object> payload) async {
    getLog().d('Sending event $event');
    if (!isConnected) return;

    try {
      await this._hubConnection.invoke(event, args: payload);
    } catch (exception) {
      getLog().e(
        'Failed to send for: $event. Ex: ${exception.toString()}',
      );
    }
  }

  Future<Result> closeConnection() async {
    getLog().d('Closing connecting to: $_baseUrl');
    if (!isConnected) return Result(false, 'Already closed');
    try {
      await this._hubConnection.stop();
      return Result(true, '');
    } catch (exception) {
      getLog().e('closingConnection Exception: ${exception.toString()}');
      return Result(false, exception.toString());
    }
  }
}
