import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mjk_apps/core/apis/tracking_order_jual_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/tracking_order_jual_get_data_dto.dart';


import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final trackingOrderJualGetDataDTOApi = Provider<TrackingOrderJualGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return TrackingOrderJualGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class TrackingOrderJualGetDataDTOService {
  TrackingOrderJualGetDataDTOService(
    Dio dio,
  ) : api = TrackingOrderJualGetDataDTOApi(
          dio,
        );
  final TrackingOrderJualGetDataDTOApi api;

  Future<Either<Failure, TrackingOrderJualGetDataResponse>> getData({
    required String action,
    required TrackingOrderJualGetFilter filters,
  }) async {
    try {
      final payload = TrackingOrderJualGetDataPayload(
        action: action,
        filters: filters,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, TrackingOrderJualGetDataResponse>(
          TrackingOrderJualGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<TrackingOrderJualGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<TrackingOrderJualGetDataResponse>().handleError(e);
    }
  }
}
