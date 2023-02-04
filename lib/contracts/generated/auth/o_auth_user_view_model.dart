import 'dart:convert';

import '../../enum/o_auth_provider_type.dart';

class OAuthUserViewModel {
  OAuthProviderType oAuthType;
  String accessToken;
  String profileUrl;
  String username;
  String tokenId;
  String email;

  OAuthUserViewModel({
    this.oAuthType = OAuthProviderType.unknown,
    this.accessToken = '',
    this.profileUrl = '',
    this.username = '',
    this.tokenId = '',
    this.email = '',
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'oAuthType': oAuthProviderTypeToInt(oAuthType),
        'profileUrl': profileUrl,
        'username': username,
        'email': email,
        'tokenId': tokenId,
        'accessToken': accessToken,
      };
}
