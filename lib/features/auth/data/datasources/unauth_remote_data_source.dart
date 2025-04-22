import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:talent_showcase_app/features/auth/data/models/auth_model.dart';
import 'package:talent_showcase_app/features/auth/data/models/auth_request_model.dart';

part 'unauth_remote_data_source.g.dart';

@RestApi(baseUrl: '/v1')
@singleton
abstract class UnauthRemoteDataSource {
  @factoryMethod
  factory UnauthRemoteDataSource(@Named('Unauthorized') Dio dio) =
      _UnauthRemoteDataSource;

  @POST('/user/login')
  Future<AuthResponseModel> login(@Body() AuthRequestModel body);
}
