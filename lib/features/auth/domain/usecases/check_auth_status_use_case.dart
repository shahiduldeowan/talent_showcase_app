import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show UseCase;
import 'package:talent_showcase_app/core/utils/type_defs.dart';
import 'package:talent_showcase_app/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class CheckAuthStatusUseCase extends UseCase<bool, void> {
  CheckAuthStatusUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  FutureResult<bool> call({void param}) => authRepository.isAuthenticated();
}
