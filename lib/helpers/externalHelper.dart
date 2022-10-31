import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalURL(String externalUrl) async {
  try {
    await launchUrl(
      Uri.parse(externalUrl),
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
      webViewConfiguration: WebViewConfiguration(
        enableJavaScript: true,
        // forceSafariVC: false,
      ),
    );
  } catch (exception) {
    getLog().e(exception.toString());
  }
}
