import 'package:dartz/dartz.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show Failure;

abstract class AuthRepository {
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, void>> logout();
}
