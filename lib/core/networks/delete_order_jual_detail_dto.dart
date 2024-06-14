import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/delete_order_jual_detail_dto_api.dart';
import 'package:mjk_apps/core/models/delete_data/delete_order_jual_detail_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setDeleteOrderJualDetailDTOApi = Provider<SetDeleteOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetDeleteOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetDeleteOrderJualDetailDTOService {
  SetDeleteOrderJualDetailDTOService(
    Dio dio,
  ) : api = DeleteOrderJualDetailDTOApi(
          dio,
        );
  final DeleteOrderJualDetailDTOApi api;

  Future<Either<Failure, DeleteOrderJualDetailResponse>> setDeleteOrderJualDetail({
    required final String action,
    required final int dihapusoleh,
    required int nomor,
  }) async {
    try {
      final payload = DeleteOrderJualDetailPayload(
        action: action,
        dihapusoleh: dihapusoleh,
      );
      final HttpResponse<dynamic> response = await api.deleteOrderJualDetail(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, DeleteOrderJualDetailResponse>(
          DeleteOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<DeleteOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<DeleteOrderJualDetailResponse>().handleError(e);
    }
  }
}
