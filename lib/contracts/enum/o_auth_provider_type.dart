enum OAuthProviderType {
  unknown,
  google,
}

int oAuthProviderTypeToInt(OAuthProviderType type) {
  switch (type) {
    case OAuthProviderType.unknown:
      return 0;
    case OAuthProviderType.google:
      return 1;
    default:
      return 0;
  }
}
