import 'package:dio/dio.dart';
import 'package:sru/core/models/set_data/update_order_jual_detail_bonus_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_order_jual_detail_bonus_dto_api.g.dart';

@RestApi()
abstract class SetUpdateOrderJualDetailBonusDTOApi {
  factory SetUpdateOrderJualDetailBonusDTOApi(Dio dio, {String baseUrl}) = _SetUpdateOrderJualDetailBonusDTOApi;

  @PUT('/api/updateData/{id}')
  Future<HttpResponse<dynamic>> updateOrderJual(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateOrderJualDetailBonusPayload payload,
  );
}
