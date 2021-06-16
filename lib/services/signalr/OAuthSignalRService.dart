import '../../constants/SignalREvents.dart';
import '../../contracts/results/result.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseSignalRService.dart';

class OAuthSignalRService extends BaseSignalRService {
  OAuthSignalRService() : super(getEnv().assistantAppsApiUrl + '/hubs/oauth');

  Future<Result> createConnection(void Function({Exception error}) onClose) =>
      this.createConnection(onClose);

  void listenToOAuth(void Function(List<Object>) onFunc) =>
      this.addListener(SignalRReceiveEvent.OAuthComplete.toString(), onFunc);

  void removeListenToOAuth() =>
      this.removeListener(SignalRReceiveEvent.OAuthComplete.toString());

  void joinGroup(String id) =>
      this.sendPayload(SignalRSendEvent.JoinOAuthGroup.toString(), [id]);

  void leaveGroup(String id) =>
      this.sendPayload(SignalRSendEvent.LeaveOAuthGroup.toString(), [id]);
}
