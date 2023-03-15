// ignore_for_file: avoid_print

import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await updateAppsJson();
  print('Done');
}

Future<void> updateAppsJson() async {
  print('Fetching apps.json');
  try {
    final response = await http.get(
      Uri.parse('https://assistantapps.com/webpack/data/apps.json'),
    );
    if (response.statusCode != 200) {
      print('Failed to fetchapps.json');
      return;
    }
    print('Writing to apps.json');
    final assistantAppLinksFile = File('./assets/data/assistantAppLinks.json');
    await assistantAppLinksFile.writeAsString(response.body);
    print('Writing to apps.json success!');
  } catch (exception) {
    print(exception);
  }
}
