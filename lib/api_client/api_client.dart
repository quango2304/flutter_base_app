import 'package:flutter_standard_app/models/user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/getUserInfo')
  Future<UserModel> getUserInfo({
    @Query('userId') String? userId,
  });
}