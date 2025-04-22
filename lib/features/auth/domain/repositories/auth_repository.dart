import 'package:talent_showcase_app/core/core_exports.dart' show FutureResult;
import 'package:talent_showcase_app/features/auth/domain/entities/auth_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_request_entity.dart';

abstract class AuthRepository {
  FutureResult<bool> isAuthenticated();
  FutureResult<void> logout();
  FutureResult<AuthEntity?> login(AuthRequestEntity request);
}
