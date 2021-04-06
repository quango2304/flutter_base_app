import 'package:dio/dio.dart';
import 'package:flutter_standard_app/api_client/api_client.dart';
import 'package:flutter_standard_app/models/user_model.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';
import 'package:flutter_standard_app/utils/helpers/query_interceptor.dart';

class UserRepository {
  late ApiClient _client;
  final AuthRepository authRepository;
  UserRepository({required this.authRepository}) {
    final dio = Dio();
    dio.interceptors.addAll([
      QueryInterceptor(
        accessToken: authRepository.getAccessToken,
        dio: dio,
        getNewToken: () async {
          return 'new token';
        }
      ),
    ]);
    _client = ApiClient(dio, baseUrl: 'EnvironmentVariable.instance.userBaseUrl');
  }

  Future<UserModel> getUserInfo({String? userId}) async {
    return await _client.getUserInfo(userId: userId);
  }
}