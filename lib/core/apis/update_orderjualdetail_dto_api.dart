import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/update_orderjual_detail_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_orderjualdetail_dto_api.g.dart';

@RestApi()
abstract class SetUpdateOrderJualDetailDTOApi {
  factory SetUpdateOrderJualDetailDTOApi(Dio dio, {String baseUrl}) = _SetUpdateOrderJualDetailDTOApi;

  @PUT('/api/updateData/{id}')
  Future<HttpResponse<dynamic>> updateOrderJualDetail(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateOrderJualDetailPayload payload,
  );
}
