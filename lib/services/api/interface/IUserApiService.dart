import 'dart:typed_data';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/generated/uploadedImageViewModel.dart';

class IUserApiService {
  Future<ResultWithValue<String>> uploadNativeImage() async {
    return ResultWithValue<String>(false, '', '');
  }

  Future<ResultWithValue<List<UploadedImageViewModel>>> uploadWebImage(
      List<String> filename, List<Uint8List> fileToUpload) async {
    return ResultWithValue<List<UploadedImageViewModel>>(
        false, List.empty(), '');
  }
}
