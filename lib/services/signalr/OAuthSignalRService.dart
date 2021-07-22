import '../../constants/SignalREvents.dart';
import '../../contracts/results/result.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseSignalRService.dart';

class OAuthSignalRService extends BaseSignalRService {
  OAuthSignalRService() : super('http://localhost:55555/hubs/oauth');

  Future<Result> connectToAuth(void Function({Exception error}) onClose) =>
      this.createConnection(onClose);

  void listenToOAuth(void Function(List<Object>) onFunc) =>
      this.addListener(SignalRReceiveEvent.OAuthComplete, onFunc);

  void removeListenToOAuth() =>
      this.removeListener(SignalRReceiveEvent.OAuthComplete);

  void joinGroup(String id) =>
      this.sendPayload(SignalRSendEvent.JoinOAuthGroup, <Object>[id]);

  void leaveGroup(String id) =>
      this.sendPayload(SignalRSendEvent.LeaveOAuthGroup, [id]);
}
