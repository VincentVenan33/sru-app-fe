import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/update_orderjualonly_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_order_jual_only_dto_api.g.dart';

@RestApi()
abstract class SetUpdateOrderJualOnlyDTOApi {
  factory SetUpdateOrderJualOnlyDTOApi(Dio dio, {String baseUrl}) = _SetUpdateOrderJualOnlyDTOApi;

  @PUT('/api/updateData/{id}')
  Future<HttpResponse<dynamic>> updateOrderJualOnly(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateOrderJualOnlyPayload payload,
  );
}
