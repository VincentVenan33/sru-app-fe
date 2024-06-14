import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/total_omset_piutang_get_data_dto_api.dart';
import 'package:mjk_apps/core/models/get_data/total_omset_piutang_get_data_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final totalOmsetpiutangGetDataDTOApi = Provider<TotalOmsetPiutangGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return TotalOmsetPiutangGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class TotalOmsetPiutangGetDataDTOService {
  TotalOmsetPiutangGetDataDTOService(
    Dio dio,
  ) : api = TotalOmsetPiutangGetDataDTOApi(
          dio,
        );
  final TotalOmsetPiutangGetDataDTOApi api;

  Future<Either<Failure, TotalOmsetPiutangGetDataResponse>> getData({
    required String action,
  }) async {
    try {
      final payload = TotalOmsetPiutangGetDataPayload(
        action: action,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, TotalOmsetPiutangGetDataResponse>(
          TotalOmsetPiutangGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<TotalOmsetPiutangGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<TotalOmsetPiutangGetDataResponse>().handleError(e);
    }
  }
}
