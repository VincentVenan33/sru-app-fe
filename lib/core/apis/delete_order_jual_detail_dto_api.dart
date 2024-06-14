import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/delete_data/delete_order_jual_detail_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'delete_order_jual_detail_dto_api.g.dart';

@RestApi()
abstract class DeleteOrderJualDetailDTOApi {
  factory DeleteOrderJualDetailDTOApi(Dio dio, {String baseUrl}) = _DeleteOrderJualDetailDTOApi;

  @DELETE('/api/deleteData/{id}')
  Future<HttpResponse<dynamic>> deleteOrderJualDetail(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() DeleteOrderJualDetailPayload payload,
  );
}
