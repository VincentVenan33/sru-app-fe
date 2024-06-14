import 'package:dio/dio.dart';
import 'package:mjk_apps/core/models/get_data/tracking_order_jual_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'tracking_order_jual_get_data_dto_api.g.dart';

@RestApi()
abstract class TrackingOrderJualGetDataDTOApi {
  factory TrackingOrderJualGetDataDTOApi(Dio dio, {String baseUrl}) = _TrackingOrderJualGetDataDTOApi;

  @POST('/api/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() TrackingOrderJualGetDataPayload payload,
  );
}
