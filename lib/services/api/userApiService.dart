import 'dart:typed_data';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../constants/ApiUrls.dart';
import '../../contracts/generated/uploadedImageViewModel.dart';
import '../../integration/dependencyInjection.dart';
import './interface/IUserApiService.dart';

class UserApiService extends BaseApiService implements IUserApiService {
  UserApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<String>> uploadNativeImage() {
    // TODO: implement uploadNativeImage
    throw UnimplementedError();
  }

  @override
  Future<ResultWithValue<List<UploadedImageViewModel>>> uploadWebImage(
      List<String> filename, List<Uint8List> fileToUpload) async {
    // var url = getEnv().assistantAppsApi + ApiUrls.userTempImage;
    // return await this.apiPostFormData(url, fileToUpload);
    return await apiPostFile(
      ApiUrls.userTempImage,
      filename,
      fileToUpload,
    );
  }
}
