import 'package:dio/dio.dart';
import 'package:talent_showcase_app/core/errors/exceptions.dart';
import 'package:talent_showcase_app/core/errors/failures.dart';

class ErrorHandler {
  /// Converts any error into a [Failure] for easier handling in the app.

  /// This function will first try to convert the error to an [AppException] using
  /// [toAppException], and then convert it to a [Failure] using [toFailure]. If
  /// the error is not a [DioException] or an [AppException], it will be converted
  /// to a [Failure.unexpected] with the error message and stack trace.
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return error.toAppException().toFailure();
    } else if (error is AppException) {
      return error.toFailure();
    } else {
      return Failure.unexpected(
        message: error.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }
}

