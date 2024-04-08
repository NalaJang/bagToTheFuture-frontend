import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late String failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        // 클라이언트 오류인 경우
        if (error.response!.statusCode! >= 400 &&
            error.response!.statusCode! < 500) {

          failure = _handleError(error);
        }
        // 서버 오류인 경우
        else if (error.response!.statusCode! >= 500 &&
            error.response!.statusCode! < 600) {
          if (error.response != null && error.response?.statusCode != null &&
              error.response?.statusMessage != null) {
            final responseData = error.response!.data;
            final errorCode = responseData['errorCode'];
            final errorMessage = responseData['errorMessage'];

            failure = '[$errorCode] $errorMessage';
          }
        }
      } else {
        failure = '그 외 에러 : $error';
      }
    } else {
      failure = 'default';
      print('default error > $error');
    }
  }
}

String _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionError:
      return 'connectionError';
    case DioExceptionType.connectionTimeout:
      return 'connectionTimeout';
    case DioExceptionType.sendTimeout:
      return 'sendTimeout';
    case DioExceptionType.receiveTimeout:
      return 'receiveTimeout';
    case DioExceptionType.badCertificate:
      return 'badCertificate';
    case DioExceptionType.badResponse:
      if( error.response != null && error.response?.statusCode != null &&
      error.response?.statusMessage != null ) {
        final responseData = error.response!.data;
        final errorCode = responseData['errorCode'];
        final errorMessage = responseData['errorMessage'];

        return '[$errorCode] $errorMessage';
      }
      return 'badResponse';
    case DioExceptionType.cancel:
      return 'cancel';
    case DioExceptionType.unknown:
      return 'unknown';
    default:
      return 'default_error';
  }
}