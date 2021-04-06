import 'package:flutter_standard_app/models/user_model.dart';

class AuthRepository {
  final Function logOut;
  String? _accessToken;

  AuthRepository({required this.logOut});
  String? get getAccessToken {
    return _accessToken;
  }

  Future<String?> getNewToken() async {
    //use refreshToken to get new token
    return null;
  }

  bool get isTokenExpired {
    return true;
  }

  Future<UserModel?> getUserInfo() async {
    //get userInfo from token
    return UserModel();
  }

  Future<UserModel?> logIn() async {
    //login then save the token and refreshToken
    return UserModel();
  }
}
