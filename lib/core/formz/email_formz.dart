import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class EmailFormz extends FormzInput<String, EmailValidationError> {
  const EmailFormz.pure() : super.pure('');
  // ignore: use_super_parameters
  const EmailFormz.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
