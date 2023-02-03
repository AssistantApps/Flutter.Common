import 'dart:convert';

import '../../helpers/jsonHelper.dart';

class UploadedImageViewModel {
  String? guid;
  String? blurHash;
  String url;
  UploadedImageViewModel({
    this.guid,
    this.blurHash,
    required this.url,
  });

  factory UploadedImageViewModel.fromRawJson(String str) =>
      UploadedImageViewModel.fromJson(json.decode(str));

  factory UploadedImageViewModel.fromJson(Map<String, dynamic> json) =>
      UploadedImageViewModel(
        guid: readStringSafe(json, 'guid'),
        blurHash: readStringSafe(json, 'blurHash'),
        url: readStringSafe(json, 'url'),
      );
}
