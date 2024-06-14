import 'package:dio/dio.dart';
import 'package:sru/core/models/get_data/produk_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'produk_get_data_dto_api.g.dart';

@RestApi()
abstract class BarangGetDataDTOApi {
  factory BarangGetDataDTOApi(Dio dio, {String baseUrl}) = _BarangGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() BarangGetDataPayload payload,
  );
}
