import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/approval_order_jual_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'approval_order_jual_dto_api.g.dart';

@RestApi()
abstract class SetApprovalOrderJualDTOApi {
  factory SetApprovalOrderJualDTOApi(Dio dio, {String baseUrl}) =
      _SetApprovalOrderJualDTOApi;

  @POST('/api/approval/orderJual/{id}')
  Future<HttpResponse<dynamic>> approvalOrderJual(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() ApprovalOrderJualPayload payload,
  );
}
