import 'package:flutter_standard_app/models/user_model.dart';

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

  Future<UserModel?> getUserInfo() async {
    return UserModel();
  }
}
