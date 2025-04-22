import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show ErrorHandler, Failure, FailureExtensions, FutureResult, Left, Right;
import 'package:talent_showcase_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:talent_showcase_app/features/auth/data/datasources/unauth_remote_data_source.dart';
import 'package:talent_showcase_app/features/auth/data/models/auth_model.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_request_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.unauthRemoteDataSource,
  });

  final AuthLocalDataSource authLocalDataSource;
  final UnauthRemoteDataSource unauthRemoteDataSource;

  @override
  FutureResult<bool> isAuthenticated() async {
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
  FutureResult<void> logout() async {
    try {
      await authLocalDataSource.clearAuthData();
      return const Right<Failure, void>(null);
    } catch (e) {
      final Failure failure = ErrorHandler.handleError(e);
      failure.logError();
      return Left<Failure, void>(failure);
    }
  }

  @override
  FutureResult<AuthEntity?> login(AuthRequestEntity request) async {
    try {
      final AuthResponseModel result = await unauthRemoteDataSource.login(
        request.toModel(),
      );
      AuthEntity? entity = result.data?.toEntity();
      if (_isAliveAccessToken(entity)) _cacheAuthData(entity!);

      return Right<Failure, AuthEntity?>(entity);
    } catch (e) {
      final Failure failure = ErrorHandler.handleError(e);
      failure.logError();

      return Left<Failure, AuthEntity>(failure);
    }
  }

  /// Checks if the access token in the entity is valid.
  bool _isAliveAccessToken(AuthEntity? entity) {
    return entity?.accessToken?.isNotEmpty ?? false;
  }

  /// Caches authentication data locally.
  Future<void> _cacheAuthData(AuthEntity entity) async {
    await authLocalDataSource.cacheAuthData(
      accessToken: entity.accessToken!,
      refreshToken: entity.refreshToken ?? '',
    );
  }
}
