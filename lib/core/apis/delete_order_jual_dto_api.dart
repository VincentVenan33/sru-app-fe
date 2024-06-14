import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/delete_data/delete_order_jual_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'delete_order_jual_dto_api.g.dart';

@RestApi()
abstract class DeleteOrderJualDTOApi {
  factory DeleteOrderJualDTOApi(Dio dio, {String baseUrl}) = _DeleteOrderJualDTOApi;

  @DELETE('/api/deleteData/{id}')
  Future<HttpResponse<dynamic>> deleteOrderJual(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() DeleteOrderJualPayload payload,
  );
}
