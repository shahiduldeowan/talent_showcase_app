import 'package:talent_showcase_app/core/core_exports.dart' show FutureResult;

abstract class AuthRepository {
  FutureResult<bool> isAuthenticated();
  FutureResult<void> logout();
}
