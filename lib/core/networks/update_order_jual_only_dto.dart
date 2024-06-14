import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/update_order_jual_only_dto_api.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/models/set_data/update_orderjualonly_dto.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setUpdateOrderJualOnlyDTOApi = Provider<SetUpdateOrderJualOnlyDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateOrderJualOnlyDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateOrderJualOnlyDTOService {
  SetUpdateOrderJualOnlyDTOService(
    Dio dio,
  ) : api = SetUpdateOrderJualOnlyDTOApi(
          dio,
        );
  final SetUpdateOrderJualOnlyDTOApi api;

  Future<Either<Failure, UpdateOrderJualOnlyResponse>> seUpdatetOrderJual({
    required String action,
    required final String nomormhrelasicust,
    required final String nomormhrelasisales,
    required final String ppnprosentase,
    required final int statusppn,
    required final int ppnnominal,
    required final int diskonprosentase,
    required final int diskonnominal,
    required final int dpp,
    required final int totalbiaya,
    required final int total,
    required final int subtotal2,
    required final String tanggal,
    required final String kode,
    required final int diubaholeh,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateOrderJualOnlyRequest(
        nomormhrelasicust: nomormhrelasicust,
        ppnprosentase: ppnprosentase,
        statusppn: statusppn,
        ppnnominal: ppnnominal,
        diskonnominal: diskonnominal,
        diskonprosentase: diskonprosentase,
        dpp: dpp,
        totalbiaya: totalbiaya,
        total: total,
        subtotal2: subtotal2,
        tanggal: tanggal,
        kode: kode,
        diubaholeh: diubaholeh,
      );
      final payload = UpdateOrderJualOnlyPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.updateOrderJualOnly(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateOrderJualOnlyResponse>(
          UpdateOrderJualOnlyResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateOrderJualOnlyResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateOrderJualOnlyResponse>().handleError(e);
    }
  }
}
