import 'package:dio/dio.dart';
import 'package:sru/core/models/set_data/update_nota_jual_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_nota_jual_dto_api.g.dart';

@RestApi()
abstract class UpdateNotaJualDTOApi {
  factory UpdateNotaJualDTOApi(Dio dio, {String baseUrl}) = _UpdateNotaJualDTOApi;

  @POST('/api/updateNotaJual/{id}')
  Future<HttpResponse<dynamic>> updateNotaJual(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateNotaJualPayload payload,
  );
}
