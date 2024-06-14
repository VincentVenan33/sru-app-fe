import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/satuan_barang_get_data_dto_api.dart';
import 'package:sru/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final satuanBarangGetDataDTOApi = Provider<SatuanBarangGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SatuanBarangGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SatuanBarangGetDataDTOService {
  SatuanBarangGetDataDTOService(
    Dio dio,
  ) : api = SatuanBarangGetDataDTOApi(
          dio,
        );
  final SatuanBarangGetDataDTOApi api;

  Future<Either<Failure, SatuanBarangGetDataResponse>> getData({
    required String action,
    required SatuanBarangGetFilter filters,
  }) async {
    try {
      final payload = SatuanBarangGetDataPayload(
        action: action,
        filters: filters,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, SatuanBarangGetDataResponse>(
          SatuanBarangGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<SatuanBarangGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<SatuanBarangGetDataResponse>().handleError(e);
    }
  }
}
