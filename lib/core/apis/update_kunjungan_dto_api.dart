import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/update_kunjungan_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_kunjungan_dto_api.g.dart';

@RestApi()
abstract class UpdateKunjunganDTOApi {
  factory UpdateKunjunganDTOApi(Dio dio, {String baseUrl}) = _UpdateKunjunganDTOApi;

  @POST('/api/updateKunjungan/{id}')
  Future<HttpResponse<dynamic>> updateKunjungan(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateKunjunganPayload payload,
  );
}
