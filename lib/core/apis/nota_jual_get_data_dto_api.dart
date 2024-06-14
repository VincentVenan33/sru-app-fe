import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/nota_jual_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'nota_jual_get_data_dto_api.g.dart';

@RestApi()
abstract class NotaJualGetDataDTOApi {
  factory NotaJualGetDataDTOApi(Dio dio, {String baseUrl}) = _NotaJualGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() NotaJualGetDataPayload payload,
  );
}
