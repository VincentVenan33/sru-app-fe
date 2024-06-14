import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/kunjungan_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/kunjungan_get_data_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final kunjunganGetDataDTOApi = Provider<KunjunganGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return KunjunganGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class KunjunganGetDataDTOService {
  KunjunganGetDataDTOService(
    Dio dio,
  ) : api = KunjunganGetDataDTOApi(
          dio,
        );
  final KunjunganGetDataDTOApi api;

  Future<Either<Failure, KunjunganGetDataResponse>> getData({
    required String action,
    required KunjunganGetFilter filters,
    required KunjunganGetSearch search,
  }) async {
    try {
      final payload = KunjunganGetDataPayload(
        action: action,
        filters: filters,
        search: [search],
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, KunjunganGetDataResponse>(
          KunjunganGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<KunjunganGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<KunjunganGetDataResponse>().handleError(e);
    }
  }
}
