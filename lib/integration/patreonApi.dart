import '../contracts/generated/auth/patreonOAuthViewModel.dart';
import './dependencyInjection.dart';

String patreonApiUrl = 'https://www.patreon.com';
String patreonApiOAuthUrl = '$patreonApiUrl/oauth2/authorize';

String getAssistantAppsPatreonOAuth() =>
    getEnv().assistantAppsApiUrl + '/OAuth/Patreon';

String getPatreonUrl(PatreonOAuthViewModel oauth) =>
    '$patreonApiOAuthUrl?response_type=code' +
    '&client_id=${getEnv().patreonOAuthClientId}' +
    '&redirect_uri=${getAssistantAppsPatreonOAuth()}' +
    '&scope=identity%20identity%5Bemail%5D' +
    '&state=${Uri.encodeComponent(oauth.toRawJson())}';
