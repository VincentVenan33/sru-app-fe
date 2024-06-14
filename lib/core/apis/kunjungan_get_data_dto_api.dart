import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/kunjungan_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'kunjungan_get_data_dto_api.g.dart';

@RestApi()
abstract class KunjunganGetDataDTOApi {
  factory KunjunganGetDataDTOApi(Dio dio, {String baseUrl}) = _KunjunganGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() KunjunganGetDataPayload payload,
  );
}
