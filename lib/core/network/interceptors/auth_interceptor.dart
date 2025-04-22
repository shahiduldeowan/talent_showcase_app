import 'package:dio/dio.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show getIt, logger;
import 'package:talent_showcase_app/features/auth/data/datasources/auth_local_data_source.dart'
    show AuthLocalDataSource;

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final String? token = await getIt<AuthLocalDataSource>().getAccessToken();
      if (token?.isNotEmpty ?? false) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (err, stk) {
      logger.e('Error getting access token!', error: err, stackTrace: stk);
    } finally {
      handler.next(options);
    }
  }

  // @override
  // void onResponse(
  //   Response<dynamic> response,
  //   ResponseInterceptorHandler handler,
  // ) {
  //   if (response.statusCode == 401) {
  //     logger.e('Token expired or unauthorized');
  //   }
  //   handler.next(response);
  // }
}
