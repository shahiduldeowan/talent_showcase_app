import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/errors/failures.dart';
import 'package:talent_showcase_app/features/splash/domain/usecases/splash_check_auth_status_usecase.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._splashCheckAuthStatusUseCase)
    : super(const SplashState.initial());
  final SplashCheckAuthStatusUseCase _splashCheckAuthStatusUseCase;

  void checkAuthStatus() async {
    emit(const SplashState.loading());

    await Future<dynamic>.delayed(const Duration(seconds: 2));

    final Either<Failure, bool> result = await _splashCheckAuthStatusUseCase();
    result.fold(
      (Failure failure) => emit(SplashState.error(failure.message)),
      (bool isAuthenticated) => _handleSuccess(isAuthenticated),
    );
  }

  void _handleSuccess(bool isAuthenticated) {
    if (isAuthenticated) {
      emit(const SplashState.authenticated());
    } else {
      emit(const SplashState.unauthenticated());
    }
  }
}
