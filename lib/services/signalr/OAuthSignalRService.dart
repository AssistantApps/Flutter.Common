import '../../constants/SignalREvents.dart';
import '../../contracts/results/result.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseSignalRService.dart';

class OAuthSignalRService extends BaseSignalRService {
  OAuthSignalRService() : super('${getEnv().assistantAppsApiUrl}/hubs/oauth');

  Future<Result> connectToAuth(void Function({Exception? error}) onClose) =>
      createConnection(onClose);

  void listenToOAuth(void Function(List<Object?>?) onFunc) =>
      addListener(SignalRReceiveEvent.oAuthComplete, onFunc);

  void removeListenToOAuth() =>
      removeListener(SignalRReceiveEvent.oAuthComplete);

  void joinGroup(String id) =>
      sendPayload(SignalRSendEvent.joinOAuthGroup, <Object>[id]);

  void leaveGroup(String id) =>
      sendPayload(SignalRSendEvent.leaveOAuthGroup, [id]);
}
