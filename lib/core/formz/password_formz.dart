import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordFormz extends FormzInput<String, PasswordValidationError> {
  const PasswordFormz.pure() : super.pure('');
  const PasswordFormz.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}
