import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/contracts/enum/networkState.dart';
import 'package:assistantapps_flutter_common/services/signalr/OAuthSignalRService.dart';
import 'package:flutter/material.dart';

import '../../components/common/image.dart';
import '../../components/list/listWithScrollbar.dart';
import '../../constants/AppImage.dart';
import '../../constants/UIConstants.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/results/result.dart';
import '../../integration/dependencyInjection.dart';

class PatreonLoginPage extends StatefulWidget {
  final String analyticsKey;
  final void Function(Result) onLogin;
  PatreonLoginPage({@required this.analyticsKey, @required this.onLogin}) {
    getAnalytics().trackEvent(this.analyticsKey);
  }

  @override
  _PatreonLoginPageWidget createState() =>
      _PatreonLoginPageWidget(this.analyticsKey, this.onLogin);
}

class _PatreonLoginPageWidget extends State<PatreonLoginPage> {
  final String analyticsKey;
  final void Function(Result) onLogin;
  //
  OAuthSignalRService oAuth = getAssistantAppsOAuthSignalR();
  NetworkState networkState = NetworkState.Loading;
  String userImgUrl = '';
  _PatreonLoginPageWidget(this.analyticsKey, this.onLogin);

  @override
  void initState() {
    void Function() errorFunc = () => this.setState(() {
          networkState = NetworkState.Error;
        });

    this.oAuth.createConnection(({error}) => errorFunc()).then(
      (Result createResult) {
        this.oAuth.listenToOAuth((List<Object> payload) {
          print('listenToOAuth');
          for (Object item in payload) {
            print(item.toString());
          }
        });
        this.setState(() {
          networkState = createResult.isSuccess //
              ? NetworkState.Success //
              : NetworkState.Error;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.patreon)),
      ),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext bodyContext) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(GestureDetector(
      child: localImage(
        AppImage.donPatreon,
        imagePackage: UIConstants.CommonPackage,
      ),
      onTap: () async {
        String deviceId = await getDeviceId();
        this.oAuth.joinGroup(deviceId);
      },
    ));

    return listWithScrollbar(
      shrinkWrap: true,
      itemCount: widgets.length,
      itemBuilder: (BuildContext innerContext, int index) => widgets[index],
    );
  }

  @override
  void dispose() {
    this.oAuth.removeListenToOAuth();
    this.oAuth.closeConnection().then((_) {
      this.oAuth = null;
    });
    super.dispose();
  }
}
