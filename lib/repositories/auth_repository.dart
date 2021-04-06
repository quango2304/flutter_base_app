class AuthRepository {
  final Function logOut;
  String? _accessToken;

  AuthRepository({required this.logOut});
  String? get getAccessToken {
    return _accessToken;
  }

  bool get isTokenExpired {
    return true;
  }
}
