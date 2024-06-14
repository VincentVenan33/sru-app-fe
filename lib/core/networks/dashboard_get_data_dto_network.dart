import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/dashboard_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/dashboard_get_data_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final dashboardGetDataDTOApi = Provider<DashboardGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return DashboardGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class DashboardGetDataDTOService {
  DashboardGetDataDTOService(
    Dio dio,
  ) : api = DashboardGetDataDTOApi(
          dio,
        );
  final DashboardGetDataDTOApi api;

  Future<Either<Failure, DashboardGetDataResponse>> getData({
    required String action,
    required DashboardGetFilter filters,
  }) async {
    try {
      final payload = DashboardGetDataPayload(
        action: action,
        filters: filters,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, DashboardGetDataResponse>(
          DashboardGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<DashboardGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<DashboardGetDataResponse>().handleError(e);
    }
  }
}
