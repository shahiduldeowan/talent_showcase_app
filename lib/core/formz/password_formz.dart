import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordFormz extends FormzInput<String, PasswordValidationError> {
  const PasswordFormz.pure() : super.pure('');
  // ignore: use_super_parameters
  const PasswordFormz.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}
