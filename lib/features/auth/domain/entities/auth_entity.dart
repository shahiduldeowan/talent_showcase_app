import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';

@freezed
abstract class AuthEntity with _$AuthEntity {
  const factory AuthEntity({String? accessToken, String? refreshToken}) =
      _AuthEntity;
}

extension AuthEntityX on AuthEntity {
  bool get isAuthenticated => accessToken != null && refreshToken != null;
}
