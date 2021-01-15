import 'package:url_launcher/url_launcher.dart';

launchExternalURL(String externalUrl) async {
  try {
    await launch(externalUrl, enableJavaScript: true, forceSafariVC: false);
  } catch (exception) {}
}
