import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talent_showcase_app/features/auth/data/models/auth_request_model.dart';

part 'auth_request_entity.freezed.dart';

@freezed
abstract class AuthRequestEntity with _$AuthRequestEntity {
  const factory AuthRequestEntity({
    required String email,
    required String password,
  }) = _AuthRequestEntity;
}

extension AuthRequestModelMapper on AuthRequestEntity {
  AuthRequestModel toModel() =>
      AuthRequestModel(email: email, password: password);
}
