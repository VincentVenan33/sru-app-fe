import 'package:dio/dio.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'create_order_jual_detail_dto_api.g.dart';

@RestApi()
abstract class SetOrderJualDetailDTOApi {
  factory SetOrderJualDetailDTOApi(Dio dio, {String baseUrl}) = _SetOrderJualDetailDTOApi;

  @POST('/api/setData')
  Future<HttpResponse<dynamic>> createOrderJualDetail(
    @Header('Accept') String accept,
    @Body() CreateOrderJualDetailPayload payload,
  );
}
