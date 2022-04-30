import 'dart:convert';

import '../../enum/oAuthProviderType.dart';

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
        'oAuthType': oAuthProviderTypeToInt(this.oAuthType),
        'profileUrl': this.profileUrl,
        'username': this.username,
        'email': this.email,
        'tokenId': this.tokenId,
        'accessToken': this.accessToken,
      };
}
