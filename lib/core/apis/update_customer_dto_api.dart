import 'package:dio/dio.dart';
import 'package:sru/core/models/set_data/update_customer_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'update_customer_dto_api.g.dart';

@RestApi()
abstract class SetUpdateCustomerDTOApi {
  factory SetUpdateCustomerDTOApi(Dio dio, {String baseUrl}) = _SetUpdateCustomerDTOApi;

  @PUT('/api/updateData/{id}')
  Future<HttpResponse<dynamic>> updateCustomer(
    @Path('id') int nomor,
    @Header('Accept') String accept,
    @Body() UpdateCustomerPayload payload,
  );
}
