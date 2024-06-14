import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/update_order_jual_detail_bonus_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:sru/core/models/set_data/update_order_jual_detail_bonus_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setUpdateOrderJualDetailBonusDTOApi = Provider<SetUpdateOrderJualDetailBonusDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateOrderJualDetailBonusDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateOrderJualDetailBonusDTOService {
  SetUpdateOrderJualDetailBonusDTOService(
    Dio dio,
  ) : api = SetUpdateOrderJualDetailBonusDTOApi(
          dio,
        );
  final SetUpdateOrderJualDetailBonusDTOApi api;

  Future<Either<Failure, UpdateOrderJualDetailResponse>> seUpdatetOrderJual({
    required String action,
    required final String nomormhcustomer,
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
    required final List<CreateOrderJualDetailRequest> detailitem,
    required int nomor,
  }) async {
    try {
      final detail = CreateDetailRequest(
        orderjualdetail: detailitem,
      );
      final requestData = UpdateOrderJualDetailBonusRequest(
        nomormhcustomer: nomormhcustomer,
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
        detail: [detail],
      );
      final payload = UpdateOrderJualDetailBonusPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.updateOrderJual(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateOrderJualDetailResponse>(
          UpdateOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateOrderJualDetailResponse>().handleError(e);
    }
  }
}
