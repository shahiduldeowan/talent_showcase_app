import 'package:dio/dio.dart';
import 'package:talent_showcase_app/core/utils/app_logger.dart' show logger;

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('➡️ Request: ${options.method} ${options.uri}');
    logger.d('Headers: ${options.headers}');
    logger.d('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger.i(
      '✅ Response: ${response.statusCode} ${response.requestOptions.uri}',
    );
    logger.d('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('❌ Error: ${err.response?.statusCode} ${err.requestOptions.uri}');
    logger.e(err.message, error: err.error, stackTrace: err.stackTrace);
    super.onError(err, handler);
  }
}
