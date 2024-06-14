import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/nota_jual_get_data_dto_api.dart';
import 'package:sru/core/models/get_data/nota_jual_get_data_dto.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final notaJualGetDataDTOApi = Provider<NotaJualGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return NotaJualGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class NotaJualGetDataDTOService {
  NotaJualGetDataDTOService(
    Dio dio,
  ) : api = NotaJualGetDataDTOApi(
          dio,
        );
  final NotaJualGetDataDTOApi api;

  Future<Either<Failure, NotaJualGetDataResponse>> getData({
    required String action,
    required NotaJualGetFilter filters,
  }) async {
    try {
      final payload = NotaJualGetDataPayload(
        action: action,
        filters: filters,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, NotaJualGetDataResponse>(
          NotaJualGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<NotaJualGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<NotaJualGetDataResponse>().handleError(e);
    }
  }
}
