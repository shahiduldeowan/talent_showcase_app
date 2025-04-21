import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show UseCase;
import 'package:talent_showcase_app/core/utils/type_defs.dart';
import 'package:talent_showcase_app/features/auth/domain/usecases/check_auth_status_use_case.dart';

@lazySingleton
class SplashCheckAuthStatusUseCase extends UseCase<bool, void> {
  SplashCheckAuthStatusUseCase(this.checkAuthStatusUseCase);

  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  @override
  FutureResult<bool> call({void param}) => checkAuthStatusUseCase();
}
