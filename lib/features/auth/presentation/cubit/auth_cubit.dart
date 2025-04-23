import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppConstants, EmailFormz, PasswordFormz;
import 'package:formz/formz.dart';
import 'package:talent_showcase_app/core/errors/failures.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_request_entity.dart';
import 'package:talent_showcase_app/features/auth/domain/usecases/login_use_case.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase) : super(const AuthState());

  final LoginUseCase _loginUseCase;

  void onPasswordVisible() {
    emit(
      state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    final EmailFormz email = EmailFormz.dirty(value);
    _updateFormStatus(email);
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String value) {
    final PasswordFormz password = PasswordFormz.dirty(value);
    _updateFormStatus(password);
    emit(state.copyWith(password: password));
  }

  Future<void> loginSubmitted() async {
    // Validate email and password
    final EmailFormz email = EmailFormz.dirty(state.email.value);
    final PasswordFormz password = PasswordFormz.dirty(state.password.value);
    final bool isValid = _validateForm(email, password);

    emit(
      state.copyWith(
        email: email,
        password: password,
        status: FormzSubmissionStatus.initial,
      ),
    );

    if (!isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    // Prepare the request body
    final AuthRequestEntity requestBody = AuthRequestEntity(
      email: email.value,
      password: password.value,
    );

    // Perform the login operation
    final Either<Failure, AuthEntity?> result = await _loginUseCase(
      param: requestBody,
    );

    result.fold(
      (Failure failure) => _handleLoginFailure(failure),
      (AuthEntity? authEntity) => _handleLoginSuccess(authEntity),
    );
  }

  void _updateFormStatus(FormzInput<dynamic, dynamic> input) {
    final bool status = Formz.validate(<FormzInput<dynamic, dynamic>>[
      input,
      state.email,
      state.password,
    ]);
    FormzSubmissionStatus formStatus =
        status ? FormzSubmissionStatus.initial : FormzSubmissionStatus.canceled;
    emit(state.copyWith(status: formStatus));
  }

  /// Validates the email and password fields.
  bool _validateForm(EmailFormz email, PasswordFormz password) {
    return Formz.validate(<FormzInput<dynamic, dynamic>>[email, password]);
  }

  /// Handles login failure by emitting an error state.
  void _handleLoginFailure(Failure failure) {
    emit(
      state.copyWith(
        errorMessage: failure.message,
        status: FormzSubmissionStatus.failure,
      ),
    );
  }

  /// Handles login success by emitting a success state or an error if the entity is null.
  void _handleLoginSuccess(AuthEntity? authEntity) {
    if (authEntity != null) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      emit(
        state.copyWith(
          errorMessage: AppConstants.invalidCredentialsMessage,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
