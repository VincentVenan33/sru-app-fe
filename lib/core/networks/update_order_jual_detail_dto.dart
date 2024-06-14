import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/update_orderjualdetail_dto_api.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/models/set_data/update_orderjual_detail_dto.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setUpdateOrderJualDetailDTOApi = Provider<SetUpdateOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateOrderJualDetailDTOService {
  SetUpdateOrderJualDetailDTOService(
    Dio dio,
  ) : api = SetUpdateOrderJualDetailDTOApi(
          dio,
        );
  final SetUpdateOrderJualDetailDTOApi api;

  Future<Either<Failure, UpdateOrderJualDetailResponse>> seUpdatetOrderJual({
    required String action,
    required final int nomorthorderjual,
    required final int nomormhbarang,
    required final int nomormhsatuan,
    required final int qty,
    required final int netto,
    required final int disctotal,
    required final int discdirect,
    required final int disc3,
    required final int disc2,
    required final int disc1,
    required final String satuanqty,
    required final int isi,
    required final String satuanisi,
    required final int harga,
    required final int subtotal,
    required final int konversisatuan,
    required final int diubaholeh,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateOrderJualDetailRequest(
        nomorthorderjual: nomorthorderjual,
        nomormhbarang: nomormhbarang,
        nomormhsatuan: nomormhsatuan,
        qty: qty,
        netto: netto,
        disctotal: disctotal,
        discdirect: discdirect,
        disc3: disc3,
        disc2: disc2,
        disc1: disc1,
        satuanqty: satuanqty,
        isi: isi,
        satuanisi: satuanisi,
        harga: harga,
        subtotal: subtotal,
        konversisatuan: konversisatuan,
        nomor: nomor,
        diubaholeh: diubaholeh,
      );
      final payload = UpdateOrderJualDetailPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.updateOrderJualDetail(
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
