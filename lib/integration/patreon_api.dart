// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import '../contracts/generated/auth/patreon_o_auth_view_model.dart';
import './dependency_injection.dart';

String patreonApiUrl = 'https://www.patreon.com';
String patreonApiOAuthUrl = '$patreonApiUrl/oauth2/authorize';

String getAssistantAppsPatreonOAuth() =>
    '${getEnv().assistantAppsApiUrl}/OAuth/Patreon';

String getPatreonUrl(PatreonOAuthViewModel oauth) =>
    '$patreonApiOAuthUrl?response_type=code' +
    '&client_id=${getEnv().patreonOAuthClientId}' +
    '&redirect_uri=${getAssistantAppsPatreonOAuth()}' +
    '&scope=identity%20identity%5Bemail%5D' +
    '&state=${Uri.encodeComponent(oauth.toRawJson())}';
