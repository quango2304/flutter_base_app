import 'package:dio/dio.dart';
import 'package:flutter_standard_app/api_client/api_client.dart';
import 'package:flutter_standard_app/models/user_model.dart';
import 'package:flutter_standard_app/utils/helpers/query_interceptor.dart';
import 'package:logger/logger.dart';

class UserRepository {
  late ApiClient _client;
  final logger = Logger();
  final String? accessToken;

  UserRepository({this.accessToken}) {
    final dio = Dio();
    dio.interceptors.addAll([
      QueryInterceptor(
        accessToken: accessToken,
      ),
    ]);
    _client = ApiClient(dio, baseUrl: 'EnvironmentVariable.instance.userBaseUrl');
  }

  Future<UserModel> getUserInfo({String? userId}) async {
    return await _client.getUserInfo(userId: userId);
  }
}