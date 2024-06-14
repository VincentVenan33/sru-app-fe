import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/omset_piutang_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'omset_piutang_get_data_dto_api.g.dart';

@RestApi()
abstract class OmsetPiutangGetDataDTOApi {
  factory OmsetPiutangGetDataDTOApi(Dio dio, {String baseUrl}) = _OmsetPiutangGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() OmsetPiutangGetDataPayload payload,
  );
}
