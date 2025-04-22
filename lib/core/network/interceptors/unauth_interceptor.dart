import 'package:dio/dio.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show logger;

class UnauthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      logger.e('🔒 Unauthorized!');
    }
    super.onError(err, handler);
  }
}
