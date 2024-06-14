import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'produk_api.g.dart';

@RestApi()
abstract class ProdukApi {
  factory ProdukApi(Dio dio, {String baseUrl}) = _ProdukApi;

  @GET('/api/produk')
  Future<HttpResponse<dynamic>> getproduk(
    @Header('Accept') String accept,
    // @Header('Authorization') String tokenLogin,
    // @Header('nomormhadmin') int nomorMhAdmin,
    // @Path() String tanggal,
  );
}
