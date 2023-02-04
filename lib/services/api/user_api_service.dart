import 'dart:typed_data';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../constants/api_urls.dart';
import '../../contracts/generated/uploaded_image_view_model.dart';
import '../../integration/dependency_injection.dart';
import './interface/i_user_api_service.dart';

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
