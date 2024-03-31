import 'package:dio/dio.dart';
import 'package:rest_api_ex/data/secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final SecureStorage storage = SecureStorage();

  // 요청 전처리(헤더 추가, 토큰 갱신 등)
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    print('[Request] [${options.method}] ${options.uri}');

    print('${options.headers}');
    if (options.headers['accessToken'] == 'true') {
      print('true');

      options.headers.remove('accessToken');
      final token = await storage.readAccessToken();
      print(token);

      options.headers.addAll({'authorization': 'Bearer $token'});

      print('[REQ_HEADER] ${options.headers}');
      print('[REQ_DATA] ${options.data}');
    } else {
      print(options.headers.keys.length);
      print(options.headers.values);
    }
  }

  // 응답 후처리(응답 로깅, 에러 처리 등)
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  }

  // 에러 처리(에러 로깅, 다시 시도 등)
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    super.onError(error, handler);

    print(
        'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');

    final refreshToken = await storage.readRefreshToken();

    if (refreshToken == null) {
      return handler.reject(error);
    }

    final isStatus401 = error.response?.statusCode == 401;
    final isPathRefresh = error.requestOptions.path == '/auth/token';

    // accessToken 필요
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      // accessToken 재발급
      try {
        final resp = await dio.post(
          'http://10.0.2.2:8080/token',
          options: Options(
            headers: {'authorization': 'Bearer $refreshToken'},
          )
        );

        // 재발급 받은 accessToken 등록
        final accessToken = resp.data['accessToken'];

        final options = error.requestOptions;

        options.headers.addAll({'authorization' : 'Bearer $accessToken'});

        await storage.saveAccessToken(accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(error);
      }
    }
    return handler.reject(error);
  }
}
