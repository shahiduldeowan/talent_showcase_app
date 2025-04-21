import 'package:dartz/dartz.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show ErrorHandler, Failure, FailureExtensions;
import 'package:talent_showcase_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:talent_showcase_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authLocalDataSource});

  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final String? token = await authLocalDataSource.getAccessToken();
      return Right<Failure, bool>(token != null);
    } catch (e) {
      final Failure failure = ErrorHandler.handleError(e);
      failure.logError();
      return Left<Failure, bool>(failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authLocalDataSource.clearAuthData();
      return const Right<Failure, void>(null);
    } catch (e) {
      final Failure failure = ErrorHandler.handleError(e);
      failure.logError();
      return Left<Failure, void>(failure);
    }
  }
}
