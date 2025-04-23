import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show UseCase;
import 'package:talent_showcase_app/core/utils/type_defs.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_request_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase extends UseCase<AuthEntity?, AuthRequestEntity> {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  FutureResult<AuthEntity?> call({AuthRequestEntity? param}) {
    return _authRepository.login(param!);
  }
}
