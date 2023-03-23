// ignore_for_file: avoid_print

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
  // print('Paste token:');
  // String? token = stdin.readLineSync(encoding: utf8);
  // if (token == null) return List.empty();
  dynamic headers = {
    "Content-Type": "application/json",
    "authorization": "Bearer eyJhbGciOiJIUzI1"
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
  if (keys.isEmpty) return;
  print('Writing to locale_key.dart');
  final file = File('./lib/contracts/enum/locale_key.dart');
  await file.writeAsString('enum LocaleKey {\n');
  for (String key in [...keys, ...additionalKeys]) {
    await file.writeAsString('  $key,\n', mode: FileMode.append);
  }

  await file.writeAsString('}\n', mode: FileMode.append);
  print('Writing to file Success');
}

List<String> additionalKeys = [
  '//',
  'inputTooShort',
  'inputTooLong',
  'emailNotValid',
  'inputTooLow',
  'inputTooHigh',
  'guideName',
  'guideSubTitle',
  'guideMinutes',
  'guideTags',
  'showCreatedBy',
  'guideSectionHeading',
  'guideSectionsAdd',
  'guideSectionAddText',
  'guideSectionAddLink',
  'guideSectionAddLinkName',
  'guideSectionAddLinkAddress',
  'guideSectionAddImage',
  'guideSectionAddImageCaption',
  'guideSectionAddMarkdown',
  'guideSectionAddMarkdownContent',
  'guideSectionAddMarkdownPreview',
  'guideSectionMoveUp',
  'guideSectionMoveDown',
  'guideSubmissionFailedTitle',
  'guideSubmissionFailedMessage',
  'guideSubmissionSuccessTitle',
  'guideSubmissionSuccessMessage',
  'loginRequiredTitle',
  'loginRequiredMessage',
];
