import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/produk_get_data_dto_api.dart';
import 'package:sru/core/models/get_data/produk_get_data_dto.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final barangGetDataDTOApi = Provider<BarangGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return BarangGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class BarangGetDataDTOService {
  BarangGetDataDTOService(
    Dio dio,
  ) : api = BarangGetDataDTOApi(
          dio,
        );
  final BarangGetDataDTOApi api;

  Future<Either<Failure, BarangGetDataResponse>> getData({
    required String action,
    required BarangGetFilter filters,
    required BarangGetSearch search,
    required String sort,
    required String orderby,
  }) async {
    try {
      final payload = BarangGetDataPayload(
        action: action,
        filters: filters,
        search: [search],
        sort: sort,
        orderby: orderby,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, BarangGetDataResponse>(
          BarangGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<BarangGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<BarangGetDataResponse>().handleError(e);
    }
  }
}
