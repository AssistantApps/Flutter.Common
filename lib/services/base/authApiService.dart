import '../../constants/ApiHeader.dart';
import '../../constants/ApiUrls.dart';
import '../../constants/LocalStorageKey.dart';
import '../../contracts/generated/auth/oAuthUserViewModel.dart';
import '../../contracts/results/result.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import 'interface/IAuthApiService.dart';

class AuthApiService extends BaseApiService implements IAuthApiService {
  AuthApiService() : super(getEnv().assistantAppsApiUrl);

  Future<ResultWithValue<DateTime>> login(
      OAuthUserViewModel oAuthDetails) async {
    Map<String, String> headers = Map<String, String>();
    try {
      final responseResult = await this.apiPost(
        ApiUrls.accountLogin,
        oAuthDetails.toRawJson(),
        headerHandler: (Map<String, String> responseHeaders) {
          headers = responseHeaders;
        },
      );
      if (responseResult.hasFailed) {
        return ResultWithValue<DateTime>(
            false, DateTime.now(), responseResult.errorMessage);
      }

      String? tokenHeader = headers[ApiHeader.token];
      if (tokenHeader == null || tokenHeader.isEmpty) {
        return ResultWithValue<DateTime>(
            false, DateTime.now(), 'AA Token header not found');
      }

      print('AA - Token');
      print(tokenHeader);

      String? tokenExpiryHeader = headers[ApiHeader.tokenExpiry];
      if (tokenExpiryHeader == null || tokenExpiryHeader.isEmpty) {
        return ResultWithValue<DateTime>(
            false, DateTime.now(), 'AA Expiry header not found');
      }

      DateTime dateTimeExpiry = DateTime.now().add(
        Duration(seconds: int.tryParse(tokenExpiryHeader) ?? 300),
      );
      Result authTokenResult =
          await getSecureStorageRepo().saveToStorageWithExpiry(
        LocalStorageKey.assistantAppsJwtToken,
        tokenHeader,
        dateTimeExpiry,
      );
      if (authTokenResult.hasFailed) {
        return ResultWithValue<DateTime>(
          authTokenResult.isSuccess,
          DateTime.now(),
          authTokenResult.errorMessage,
        );
      }

      String? assistantAppsGuidHeader = headers[ApiHeader.userGuid];
      if (assistantAppsGuidHeader == null || assistantAppsGuidHeader.isEmpty) {
        return ResultWithValue<DateTime>(
            false, DateTime.now(), 'userGuid header not found');
      }

      String? userNameHeader = headers[ApiHeader.userName];
      if (userNameHeader == null || userNameHeader.isEmpty) {
        return ResultWithValue<DateTime>(
            false, DateTime.now(), 'AssistantApps userGuid header not found');
      }
      print('userNameHeader');
      print(userNameHeader);

      return ResultWithValue<DateTime>(true, dateTimeExpiry, '');
    } catch (exception) {
      getLog().e("AuthApiService-Login Exception: ${exception.toString()}");
      return ResultWithValue<DateTime>(
          false, DateTime.now(), exception.toString());
    }
  }

  Future<Result> logout() async {
    try {
      await getSecureStorageRepo().saveToStorageWithExpiry(
        LocalStorageKey.assistantAppsJwtToken,
        '',
        DateTime.now(),
      );
      return Result(true, '');
    } catch (exception) {
      return Result(false, exception.toString());
    }
  }
}
