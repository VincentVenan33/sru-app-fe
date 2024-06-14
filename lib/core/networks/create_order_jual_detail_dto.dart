import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/create_order_jual_detail_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setOrderJualDetailDTOApi = Provider<SetOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetOrderJualDetailDTOService {
  SetOrderJualDetailDTOService(
    Dio dio,
  ) : api = SetOrderJualDetailDTOApi(
          dio,
        );
  final SetOrderJualDetailDTOApi api;

  Future<Either<Failure, CreateOrderJualDetailResponse>> setOrderJualDetail({
    required final String action,
    required final int? nomorthorderjual,
    required final int? nomormhbarang,
    required final int? nomormhsatuan,
    required final int? qty,
    required final int? netto,
    required final int? disctotal,
    required final int? discdirect,
    required final int? disc3,
    required final int? disc2,
    required final int? disc1,
    required final String satuanqty,
    required final int? isi,
    required final String satuanisi,
    required final int? harga,
    required final int subtotal,
    required final int konversisatuan,
  }) async {
    try {
      final requestData = CreateOrderJualDetailRequest(
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
      );
      final payload = CreateOrderJualDetailPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.createOrderJualDetail(
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
