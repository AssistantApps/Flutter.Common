import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  List<String> keys = await getTranslationKeys();
  await writeServerData(keys);
  print('Done');
}

Future<List<String>> getTranslationKeys() async {
  print('Fetching TranlationKeys');
  dynamic headers = {
    "Content-Type": "application/json",
    "authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ikt1cnQgTG91cmVucyIsIlVzZXJJZCI6IjZhOGI0YTViLWY2MzktNGIyYS1kZTRkLTA4ZDg0OTM4OGU5ZiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjEwMDAwIiwiYXV0aG1ldGhvZCI6IkpXVCIsIm5iZiI6MTY0NDQ4ODE4OSwiZXhwIjoxNjQ0NDk4MTg5LCJpYXQiOjE2NDQ0ODgxODksImlzcyI6Ikt1cnRMb3VyZW5zIiwiYXVkIjoiRGVtb0F1ZGllbmNlIn0.o9pOBAUOitdVkiZfeBWHPiffhkBiklFA2uMnxM_Xt3g"
  };
  try {
    final response = await http.get(
      Uri.parse('https://api.assistantapps.com/TranslationKey/Admin'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      return List.empty();
    }
    List list = json.decode(response.body);
    List<String> result = list.map((e) => e["key"].toString()).toSet().toList();
    print('Fetch & Mapping Success');
    return result;
  } catch (exception) {
    print(exception);
    return List.empty();
  }
}

Future writeServerData(List<String> keys) async {
  if (keys.length < 1) return;
  print('Writing to LocaleKey.dart');
  final file = File('./lib/contracts/enum/localeKey.dart');
  await file.writeAsString('enum LocaleKey {\n');
  for (int keyIndex = 0; keyIndex < (keys.length - 1); keyIndex++) {
    var key = keys[keyIndex];
    await file.writeAsString('  $key,\n', mode: FileMode.append);
  }
  var lastItem = keys[(keys.length - 1)];
  await file.writeAsString('  $lastItem\n', mode: FileMode.append);
  await file.writeAsString('}\n', mode: FileMode.append);
  print('Writing to file Success');
}
