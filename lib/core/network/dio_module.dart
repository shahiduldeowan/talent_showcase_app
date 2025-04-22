import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/network/interceptors/auth_interceptor.dart';
import 'package:talent_showcase_app/core/network/interceptors/logging_interceptor.dart';
import 'package:talent_showcase_app/core/network/interceptors/unauth_interceptor.dart';
import 'package:talent_showcase_app/core/utils/environments.dart';

final String _baseUrl = Environments.appBaseUrl;
const Duration _requestTimeoutInSeconds = Duration(seconds: 30);

@module
abstract class DioModule {
  @Named('Authorized')
  @singleton
  Dio createAuthorizedDioClient() {
    final Dio dioClient = _dioClient();
    dioClient.interceptors.addAll(<Interceptor>[
      AuthInterceptor(),
      LoggingInterceptor(),
    ]);

    return dioClient;
  }

  @Named('Unauthorized')
  @singleton
  Dio createUnauthorizedDioClient() {
    final Dio dioClient = _dioClient();
    dioClient.interceptors.addAll(<Interceptor>[
      UnauthInterceptor(),
      LoggingInterceptor(),
    ]);

    return dioClient;
  }

  Dio _dioClient() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: _requestTimeoutInSeconds,
      receiveTimeout: _requestTimeoutInSeconds,
    );
    return Dio(baseOptions);
  }
}
