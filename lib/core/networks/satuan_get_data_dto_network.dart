import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/satuan_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/satuan_get_data_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final satuanGetDataDTOApi = Provider<SatuanGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SatuanGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SatuanGetDataDTOService {
  SatuanGetDataDTOService(
    Dio dio,
  ) : api = SatuanGetDataDTOApi(
          dio,
        );
  final SatuanGetDataDTOApi api;

  Future<Either<Failure, SatuanGetDataResponse>> getData({
    required String action,
  }) async {
    try {
      final payload = SatuanGetDataPayload(
        action: action,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, SatuanGetDataResponse>(
          SatuanGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<SatuanGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<SatuanGetDataResponse>().handleError(e);
    }
  }
}
