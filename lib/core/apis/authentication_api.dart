import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/authentication/login.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String baseUrl}) = _AuthenticationApi;

  @POST('/api/login')
  Future<HttpResponse<dynamic>> login(
    @Header('Accept') String accept,
    @Body() LoginRequest payload,
  );
}
