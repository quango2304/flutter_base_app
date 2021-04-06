class AuthRepository {
  String? _accessToken;
  String? get getAccessToken {
    return _accessToken;
  }

  bool get isTokenExpired {
    return true;
  }
}
