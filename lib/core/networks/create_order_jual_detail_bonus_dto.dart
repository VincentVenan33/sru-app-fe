import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/create_order_jual_detail_bonus_dto_api.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setOrderJualDetailBonusDTOApi = Provider<SetOrderJualDetailBonusDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetOrderJualDetailBonusDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetOrderJualDetailBonusDTOService {
  SetOrderJualDetailBonusDTOService(
    Dio dio,
  ) : api = SetOrderJualDetailBonusDTOApi(
          dio,
        );
  final SetOrderJualDetailBonusDTOApi api;

  Future<Either<Failure, CreateOrderJualDetailResponse>> setOrderJual({
    required String action,
    required final String formatcode,
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
    required final int dibuatoleh,
    required final List<CreateOrderJualDetailRequest> detailitem,
  }) async {
    try {
      final detail = CreateDetailRequest(
        orderjualdetail: detailitem,
      );
      final requestData = CreateOrderJualDetailBonusRequest(
        formatcode: formatcode,
        nomormhrelasicust: nomormhrelasicust,
        nomormhrelasisales: nomormhrelasisales,
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
        dibuatoleh: dibuatoleh,
        detail: [detail],
      );
      final payload = CreateOrderJualDetailBonusPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.createOrderJual(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, CreateOrderJualDetailResponse>(
          CreateOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<CreateOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<CreateOrderJualDetailResponse>().handleError(e);
    }
  }
}
