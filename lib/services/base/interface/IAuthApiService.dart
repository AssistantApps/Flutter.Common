import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class IAuthApiService {
  Future<ResultWithValue<DateTime>> login(
      OAuthUserViewModel oAuthDetails) async {
    return ResultWithValue<DateTime>(false, DateTime.now(), '');
  }

  Future<Result> logout() async {
    return Result(false, '');
  }
}
