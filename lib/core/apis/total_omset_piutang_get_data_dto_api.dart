import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/total_omset_piutang_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'total_omset_piutang_get_data_dto_api.g.dart';

@RestApi()
abstract class TotalOmsetPiutangGetDataDTOApi {
  factory TotalOmsetPiutangGetDataDTOApi(Dio dio, {String baseUrl}) = _TotalOmsetPiutangGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() TotalOmsetPiutangGetDataPayload payload,
  );
}
