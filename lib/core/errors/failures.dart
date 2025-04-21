import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talent_showcase_app/core/errors/exceptions.dart';
import 'package:talent_showcase_app/core/utils/app_logger.dart' show logger;

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.unexpected({
    required String message,
    required StackTrace stackTrace,
  }) = UnexpectedFailure;

  const factory Failure.network({
    required String message,
    required StackTrace stackTrace,
  }) = NetworkFailure;

  const factory Failure.invalidCredentials({
    required String message,
    required StackTrace stackTrace,
  }) = InvalidCredentialsFailure;

  const factory Failure.tokenExpired({
    required String message,
    required StackTrace stackTrace,
  }) = TokenExpiredFailure;

  const factory Failure.cache({
    required String message,
    required StackTrace stackTrace,
  }) = CacheFailure;

  const factory Failure.server({
    required String message,
    required int? statusCode,
    required dynamic responseData,
    required StackTrace stackTrace,
  }) = ServerFailure;
}

/// Extension for UI-friendly messages and actions
extension FailureExtensions on Failure {
  String get userFriendlyMessage {
    if (this is UnexpectedFailure) {
      return 'Unexpected error: ${(this as UnexpectedFailure).message}';
    } else if (this is NetworkFailure) {
      return 'Network error: ${(this as NetworkFailure).message}';
    } else if (this is InvalidCredentialsFailure) {
      return 'Invalid email or password';
    } else if (this is TokenExpiredFailure) {
      return 'Session expired. Please login again';
    } else if (this is CacheFailure) {
      return 'Storage error: ${(this as CacheFailure).message}';
    } else if (this is ServerFailure) {
      final ServerFailure serverFailure = this as ServerFailure;
      return serverFailure.statusCode == 500
          ? 'Server maintenance in progress'
          : 'Server error (${serverFailure.statusCode ?? 'unknown'})';
    }
    return 'An unknown error occurred';
  }

  bool get shouldLogout {
    return this is TokenExpiredFailure;
  }

  void logError() {
    logger.e(userFriendlyMessage);
    if (this is UnexpectedFailure) {
      logger.e('StackTrace', stackTrace: stackTrace);
    }
  }
}

/// Converts exceptions to failures
extension ExceptionToFailure on Exception {
  Failure toFailure() {
    if (this is CacheException) {
      final CacheException e = this as CacheException;
      return Failure.cache(
        message: e.message,
        stackTrace: e.stackTrace ?? StackTrace.current,
      );
    } else if (this is ServerException) {
      final ServerException e = this as ServerException;
      return Failure.server(
        message: e.message,
        statusCode: e.statusCode,
        responseData: e.responseData,
        stackTrace: e.stackTrace ?? StackTrace.current,
      );
    } else if (this is TokenExpiredException) {
      final TokenExpiredException e = this as TokenExpiredException;
      return Failure.tokenExpired(
        message: e.message,
        stackTrace: e.stackTrace ?? StackTrace.current,
      );
    } else if (this is InvalidCredentialsException) {
      final InvalidCredentialsException e = this as InvalidCredentialsException;
      return Failure.invalidCredentials(
        message: e.message,
        stackTrace: e.stackTrace ?? StackTrace.current,
      );
    } else if (this is NetworkException) {
      final NetworkException e = this as NetworkException;
      return Failure.network(
        message: e.message,
        stackTrace: e.stackTrace ?? StackTrace.current,
      );
    }
    return Failure.unexpected(
      message: toString(),
      stackTrace: StackTrace.current,
    );
  }
}
