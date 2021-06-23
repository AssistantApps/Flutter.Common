import 'package:assistantapps_flutter_common/contracts/generated/auth/patreonOAuthViewModel.dart';
import 'package:assistantapps_flutter_common/integration/patreonApi.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/enum/networkState.dart';
import '../../integration/dependencyInjection.dart';
import '../common/space.dart';

class PatreonLoginModalBottomSheet extends StatefulWidget {
  final String analyticsKey;
  final void Function(Result) onLogin;
  PatreonLoginModalBottomSheet(this.analyticsKey, this.onLogin);
  @override
  _PatreonLoginModalBottomSheetWidget createState() =>
      _PatreonLoginModalBottomSheetWidget(analyticsKey, onLogin);
}

class _PatreonLoginModalBottomSheetWidget
    extends State<PatreonLoginModalBottomSheet> with TickerProviderStateMixin {
  final String analyticsKey;
  final void Function(Result) onLogin;

  String _deviceId;
  NetworkState _signalRNetworkState = NetworkState.Loading;
  OAuthSignalRService _oAuthSignal = getAssistantAppsOAuthSignalR();
  _PatreonLoginModalBottomSheetWidget(this.analyticsKey, this.onLogin);

  @override
  void initState() {
    _oAuthSignal
        .connectToAuth(connectionFailed)
        .then((Result connectionResult) {
      if (connectionResult.hasFailed)
        connectionFailed();
      else
        setupListeners();
    });
    super.initState();
  }

  void connectionFailed({Exception error}) {
    this.setState(() {
      _signalRNetworkState = NetworkState.Error;
    });
  }

  Future<void> setupListeners() async {
    String deviceId = await getDeviceId();
    _oAuthSignal.joinGroup(deviceId);
    _oAuthSignal.listenToOAuth((List<Object> payload) {
      print('listenToOAuth');
      for (Object data in payload) {
        print(data);
      }
      getNavigation().pop(context);
    });
    this.setState(() {
      _deviceId = deviceId;
      _signalRNetworkState = NetworkState.Success;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_signalRNetworkState == NetworkState.Loading) {
      return displayContentInModal(
        centerContentInModal(
          [
            getLoading().smallLoadingIndicator(),
            emptySpace2x(),
            Text('Connecting to Server'),
          ],
        ),
      );
    }
    if (_signalRNetworkState == NetworkState.Error) {
      return displayContentInModal(
        centerContentInModal(
          [Center(child: Text('Could not connect to authentication servers'))],
        ),
      );
    }

    List<Widget> widgets = List.empty(growable: true);
    widgets.add(emptySpace1x());
    widgets.add(positiveButton(
      title: 'Login with Patreon',
      onPress: () {
        var patreonRequestUrl = getPatreonUrl(
          PatreonOAuthViewModel(uniqueIdentifier: _deviceId),
        );
        print(patreonRequestUrl);
        // launchExternalURL(patreonRequestUrl);
      },
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
          vsync: this,
          duration: const Duration(milliseconds: 150),
          child: Container(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height) / 3,
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
    _oAuthSignal.closeConnection().then((_) {
      _oAuthSignal = null;
    });
  }
}
