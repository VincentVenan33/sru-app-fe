import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/create_order_jual_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/create_order_jual_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setOrderJualDTOApi = Provider<SetOrderJualDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetOrderJualDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetOrderJualDTOService {
  SetOrderJualDTOService(
    Dio dio,
  ) : api = SetOrderJualDTOApi(
          dio,
        );
  final SetOrderJualDTOApi api;

  Future<Either<Failure, CreateOrderJualResponse>> setOrderJual({
    required String action,
    required final String formatcode,
    required final int nomormhcustomer,
    required final String ppnprosentase,
    required final int? statusppn,
    required final String tanggal,
    required final String kode,
    required final int? dibuatoleh,
  }) async {
    try {
      final requestData = CreateOrderJualRequest(
        formatcode: formatcode,
        nomormhcustomer: nomormhcustomer,
        ppnprosentase: ppnprosentase,
        statusppn: statusppn,
        tanggal: tanggal,
        kode: kode,
        dibuatoleh: dibuatoleh,
      );
      final payload = CreateOrderJualPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.createOrderJual(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, CreateOrderJualResponse>(
          CreateOrderJualResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<CreateOrderJualResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<CreateOrderJualResponse>().handleError(e);
    }
  }
}
