import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/total_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'total_get_data_dto_api.g.dart';

@RestApi()
abstract class TotalGetDataDTOApi {
  factory TotalGetDataDTOApi(Dio dio, {String baseUrl}) = _TotalGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() TotalGetDataPayload payload,
  );
}
