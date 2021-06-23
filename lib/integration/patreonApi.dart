import '../contracts/generated/auth/patreonOAuthViewModel.dart';
import 'dependencyInjection.dart';

String patreonApiUrl = 'https://www.patreon.com';
String patreonApiOAuthUrl = '$patreonApiUrl/oauth2/authorize';

String getPatreonUrl(PatreonOAuthViewModel oauth) =>
    '$patreonApiOAuthUrl?response_type=code' +
    '&client_id=${getEnv().patreonOAuthClientId}' +
    '&redirect_uri=${getEnv().patreonOAuthRedirectUrl}' +
    '&scope=identity' +
    '&state=${Uri.encodeComponent(oauth.toRawJson())}';
