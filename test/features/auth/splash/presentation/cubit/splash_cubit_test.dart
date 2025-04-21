import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talent_showcase_app/core/errors/failures.dart';
import 'package:talent_showcase_app/features/splash/domain/usecases/splash_check_auth_status_usecase.dart';
import 'package:talent_showcase_app/features/splash/presentation/cubit/splash_cubit.dart';

class MockSplashCheckAuthStatusUseCase extends Mock
    implements SplashCheckAuthStatusUseCase {}

void main() {
  late MockSplashCheckAuthStatusUseCase mockUseCase;
  late SplashCubit splashCubit;

  setUp(() {
    mockUseCase = MockSplashCheckAuthStatusUseCase();
    splashCubit = SplashCubit(mockUseCase);
  });

  tearDown(() {
    splashCubit.close();
  });

  group('SplashCubit', () {
    blocTest<SplashCubit, SplashState>(
      'emits [loading, authenticated] when user is authenticated',
      build: () {
        when(
          () => mockUseCase(),
        ).thenAnswer((_) async => const Right<Failure, bool>(true));
        return splashCubit;
      },
      act: (SplashCubit cubit) => cubit.checkAuthStatus(),
      wait: const Duration(seconds: 3), // Wait for the delay
      expect:
          () => <SplashState>[
            const SplashState.loading(),
            const SplashState.authenticated(),
          ],
      verify: (_) {
        verify(() => mockUseCase()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [loading, unauthenticated] when user is not authenticated',
      build: () {
        when(
          () => mockUseCase(),
        ).thenAnswer((_) async => const Right<Failure, bool>(false));
        return splashCubit;
      },
      act: (SplashCubit cubit) => cubit.checkAuthStatus(),
      wait: const Duration(seconds: 3), // Wait for the delay
      expect:
          () => <SplashState>[
            const SplashState.loading(),
            const SplashState.unauthenticated(),
          ],
      verify: (_) {
        verify(() => mockUseCase()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [loading, error] when there is a failure',
      build: () {
        when(() => mockUseCase()).thenAnswer(
          (_) async => Left<Failure, bool>(
            Failure.unexpected(
              message: 'Test error',
              stackTrace: StackTrace.current,
            ),
          ),
        );
        return splashCubit;
      },
      act: (SplashCubit cubit) => cubit.checkAuthStatus(),
      wait: const Duration(seconds: 3), // Wait for the delay
      expect:
          () => <SplashState>[
            const SplashState.loading(),
            const SplashState.error('Test error'),
          ],
      verify: (_) {
        verify(() => mockUseCase()).called(1);
      },
    );
  });
}
