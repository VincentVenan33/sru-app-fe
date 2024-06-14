import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/omset_piutang_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/omset_piutang_get_data_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final omsetpiutangGetDataDTOApi = Provider<OmsetPiutangGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return OmsetPiutangGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class OmsetPiutangGetDataDTOService {
  OmsetPiutangGetDataDTOService(
    Dio dio,
  ) : api = OmsetPiutangGetDataDTOApi(
          dio,
        );
  final OmsetPiutangGetDataDTOApi api;

  Future<Either<Failure, OmsetPiutangGetDataResponse>> getData({
    required String action,
  }) async {
    try {
      final payload = OmsetPiutangGetDataPayload(
        action: action,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, OmsetPiutangGetDataResponse>(
          OmsetPiutangGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<OmsetPiutangGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<OmsetPiutangGetDataResponse>().handleError(e);
    }
  }
}
