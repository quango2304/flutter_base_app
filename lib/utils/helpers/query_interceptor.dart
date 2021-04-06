import 'package:dio/dio.dart';
class QueryInterceptor extends Interceptor {
  final String? accessToken;
  final Dio dio;
  final Future<String> Function() getNewToken;

  QueryInterceptor({this.accessToken, required this.dio, required this.getNewToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (accessToken != null) {
      options.headers['authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 403) {
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();
      RequestOptions options = error.requestOptions;
      final token = await getNewToken();
      options.headers["Authorization"] = "Bearer " + token;
      dio.interceptors.requestLock.unlock();
      dio.interceptors.responseLock.unlock();
      return super.onRequest(options, RequestInterceptorHandler());
    }
    return super.onError(error, handler);
  }
}