import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'create_order_jual_detail_bonus_dto_api.g.dart';

@RestApi()
abstract class SetOrderJualDetailBonusDTOApi {
  factory SetOrderJualDetailBonusDTOApi(Dio dio, {String baseUrl}) = _SetOrderJualDetailBonusDTOApi;

  @POST('/api/setData')
  Future<HttpResponse<dynamic>> createOrderJual(
    @Header('Accept') String accept,
    @Body() CreateOrderJualDetailBonusPayload payload,
  );
}
