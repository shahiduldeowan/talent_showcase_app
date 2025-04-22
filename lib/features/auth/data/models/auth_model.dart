import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talent_showcase_app/features/auth/domain/entities/auth_entity.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    String? status,
    int? statusCode,
    AuthDataModel? data,
    @Default(<dynamic>[]) List<dynamic> errors,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

@freezed
abstract class AuthDataModel with _$AuthDataModel {
  const factory AuthDataModel({String? accessToken, String? refreshToken}) =
      _AuthDataModel;

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  AuthEntity toEntity() =>
      AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
}
