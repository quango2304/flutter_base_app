import 'package:dio/dio.dart';
class QueryInterceptor extends Interceptor {
  final String? accessToken;

  QueryInterceptor({this.accessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    if (accessToken != null) {
      options.headers['authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options, handler);
  }
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   return super.onResponse(response, handler);
  // }
  //
  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   return super.onError(err, handler);
  // }
}