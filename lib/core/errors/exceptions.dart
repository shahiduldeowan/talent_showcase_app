import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  @override
  String toString() =>
      '$runtimeType: $message${stackTrace != null ? '\n$stackTrace' : ''}';
}

class CacheException extends AppException {
  const CacheException(super.message, [super.stackTrace]);
}

class ServerException extends AppException {
  final int? statusCode;
  final dynamic responseData;

  const ServerException({
    required String message,
    this.statusCode,
    this.responseData,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

/// Auth-specific exceptions
class AuthException extends AppException {
  const AuthException(super.message, [super.stackTrace]);
}

class TokenExpiredException extends AuthException {
  const TokenExpiredException({StackTrace? stackTrace})
    : super('Authentication token has expired', stackTrace);
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({StackTrace? stackTrace})
    : super('Invalid email or password', stackTrace);
}

class NetworkException extends AppException {
  const NetworkException(super.message, [super.stackTrace]);
}

extension DioErrorMapper on DioException {
  AppException toAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Request timed out', stackTrace);
      case DioExceptionType.badResponse:
        return _handleBadResponse(this);
      case DioExceptionType.cancel:
        return ServerException(
          message: 'Request cancelled',
          stackTrace: stackTrace,
        );
      case DioExceptionType.unknown:
        return NetworkException(
          'Network error: ${error?.toString() ?? 'Unknown'}',
          stackTrace,
        );
      case DioExceptionType.badCertificate:
        return ServerException(
          message: 'Invalid certificate',
          stackTrace: stackTrace,
        );
      case DioExceptionType.connectionError:
        return NetworkException('Connection failed', stackTrace);
    }
  }

  AppException _handleBadResponse(DioException e) {
    final int? statusCode = e.response?.statusCode;
    final dynamic data = e.response?.data;

    if (statusCode == 401) {
      if (data is Map &&
          data['message']?.toString().contains('expired') == true) {
        return const TokenExpiredException();
      }
      return const InvalidCredentialsException();
    }

    return ServerException(
      message: data?['message']?.toString() ?? e.message ?? 'Server error',
      statusCode: statusCode,
      responseData: data,
      stackTrace: stackTrace,
    );
  }
}
