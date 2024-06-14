import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/set_data/create_customer_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'create_customer_dto_api.g.dart';

@RestApi()
abstract class SetCustomerDTOApi {
  factory SetCustomerDTOApi(Dio dio, {String baseUrl}) = _SetCustomerDTOApi;

  @POST('/api/setData')
  Future<HttpResponse<dynamic>> createCustomer(
    @Header('Accept') String accept,
    @Body() CreateCustomerPayload payload,
  );
}
