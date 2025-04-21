part of 'splash_cubit.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = SplashStateInitial;
  const factory SplashState.loading() = SplashStateLoading;
  const factory SplashState.authenticated() = SplashStateAuthenticated;
  const factory SplashState.unauthenticated() = SplashStateUnauthenticated;
  const factory SplashState.error(String message) = SplashStateError;
}
