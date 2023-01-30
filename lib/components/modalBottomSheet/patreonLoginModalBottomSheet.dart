import 'package:flutter/material.dart';

import '../../contracts/enum/networkState.dart';
import '../../contracts/generated/auth/patreonOAuthResponseViewModel.dart';
import '../../contracts/generated/auth/patreonOAuthViewModel.dart';
import '../../contracts/results/result.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../integration/patreonApi.dart';
import '../../services/signalr/OAuthSignalRService.dart';
import '../common/authButtons.dart';
import '../common/space.dart';
import '../list/listWithScrollbar.dart';

class PatreonLoginModalBottomSheet extends StatefulWidget {
  final String analyticsKey;
  final void Function(Result) onLogin;

  const PatreonLoginModalBottomSheet(this.analyticsKey, this.onLogin,
      {Key? key})
      : super(key: key);

  @override
  createState() => _PatreonLoginModalBottomSheetWidget();
}

class _PatreonLoginModalBottomSheetWidget
    extends State<PatreonLoginModalBottomSheet> {
  late String _deviceId;
  NetworkState _signalRNetworkState = NetworkState.loading;
  final OAuthSignalRService _oAuthSignal = getAssistantAppsOAuthSignalR();

  @override
  void initState() {
    _oAuthSignal
        .connectToAuth(connectionFailed)
        .then((Result connectionResult) {
      if (connectionResult.hasFailed) {
        connectionFailed();
      } else {
        setupListeners();
      }
    });
    super.initState();
  }

  void connectionFailed({Exception? error}) {
    setState(() {
      _signalRNetworkState = NetworkState.error;
    });
  }

  Future<void> setupListeners() async {
    String deviceId = await getDeviceId();
    getLog().d(deviceId);
    _oAuthSignal.joinGroup(deviceId);
    _oAuthSignal.listenToOAuth((List<Object?>? payload) {
      getLog().d('listenToOAuth');

      if (payload == null || payload.length < 2) {
        widget.onLogin(Result(false, 'invalid payload'));
        return;
      }

      PatreonOAuthResponseViewModel objFromServer =
          PatreonOAuthResponseViewModel(
        loginFailed: (payload[0]) as bool,
        belongsToAssistantAppsCampaign: (payload[1]) as bool,
        errorMessage: (payload[2]) as String,
      );

      getLog().i('loginFailed ${objFromServer.loginFailed}');
      getLog().i(
          'belongsToAssistantAppsCampaign ${objFromServer.belongsToAssistantAppsCampaign}');

      if (objFromServer.loginFailed != false ||
          objFromServer.belongsToAssistantAppsCampaign != true) {
        widget.onLogin(Result(
          false,
          'loginFailed or belongsToAssistantAppsCampaign',
        ));
        return;
      }

      widget.onLogin(Result(true, ''));
      getNavigation().pop(context);
    });
    setState(() {
      _deviceId = deviceId;
      _signalRNetworkState = NetworkState.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_signalRNetworkState == NetworkState.loading) {
      return displayContentInModal(
        centerContentInModal(
          [
            getLoading().smallLoadingIndicator(),
            const EmptySpace2x(),
            const Text('Connecting to Server'),
          ],
        ),
      );
    }
    if (_signalRNetworkState == NetworkState.error) {
      return displayContentInModal(
        centerContentInModal(
          [
            const Center(
              child: Text('Could not connect to authentication servers'),
            )
          ],
        ),
      );
    }

    List<Widget> widgets = List.empty(growable: true);
    widgets.add(const EmptySpace1x());
    widgets.add(Padding(
      padding: const EdgeInsets.only(left: 12, top: 6, right: 12),
      child: AuthButton.patreon(
        onPressed: () {
          String oAuthUrl = getPatreonUrl(
            PatreonOAuthViewModel(uniqueIdentifier: _deviceId),
          );
          getLog().d(oAuthUrl);
          launchExternalURL(oAuthUrl);
        },
      ),
    ));

    return displayContentInModal(
      listWithScrollbar(
        shrinkWrap: true,
        itemCount: widgets.length,
        itemBuilder: (BuildContext innerContext, int index) => widgets[index],
      ),
    );
  }

  Widget displayContentInModal(Widget content) {
    return Stack(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          child: Container(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height) / 4,
            ),
            child: content,
          ),
        ),
      ],
    );
  }

  Widget centerContentInModal(List<Widget> innerChildren) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: innerChildren,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _oAuthSignal.leaveGroup(_deviceId);
    _oAuthSignal.removeListenToOAuth();
    _oAuthSignal.closeConnection();
  }
}
