import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/create_kunjungan_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'create_kunjungan_dto_api.g.dart';

@RestApi()
abstract class CreateKunjunganDTOApi {
  factory CreateKunjunganDTOApi(Dio dio, {String baseUrl}) = _CreateKunjunganDTOApi;

  @POST('/api/setData')
  Future<HttpResponse<dynamic>> createKunjungan(
    @Header('Accept') String accept,
    @Body() CreateKunjunganPayload payload,
  );
}
