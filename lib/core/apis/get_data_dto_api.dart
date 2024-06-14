import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'get_data_dto_api.g.dart';

@RestApi()
abstract class GetDataDTOApi {
  factory GetDataDTOApi(Dio dio, {String baseUrl}) = _GetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() GetDataPayload payload,
  );
}
