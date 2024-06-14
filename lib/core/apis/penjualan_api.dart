import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mjk_apps/core/models/penjualan/approval_order_penjualan.dart';

part 'penjualan_api.g.dart';

@RestApi()
abstract class PenjualanApi {
  factory PenjualanApi(Dio dio, {String baseUrl}) = _PenjualanApi;

  @GET('/api/thorderjuals/{tanggal}')
  Future<HttpResponse<dynamic>> getOrderJuals(
    @Header('Accept') String accept,
    @Header('Authorization') String tokenLogin,
    @Header('nomormhadmin') int nomorMhAdmin,
    @Path() String tanggal,
  );

  @POST('/api/thorderjuals/owner_approval')
  Future<HttpResponse<dynamic>> approveOrderJual(
    @Header('Accept') String accept,
    @Header('Authorization') String tokenLogin,
    @Header('nomormhadmin') int nomorMhAdmin,
    @Body() ApproveOrderJualRequest payload,
  );
}
