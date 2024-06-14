// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/delete_order_jual_bonus_detail_dto_api.dart';
import 'package:mjk_apps/core/models/delete_data/delete_order_jual_bonus_detail_dto.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setDeleteOrderJualBonusDetailDTOApi = Provider<SetDeleteOrderJualBonusDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetDeleteOrderJualBonusDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetDeleteOrderJualBonusDetailDTOService {
  SetDeleteOrderJualBonusDetailDTOService(
    Dio dio,
  ) : api = DeleteOrderJualBonusDetailDTOApi(
          dio,
        );
  final DeleteOrderJualBonusDetailDTOApi api;

  Future<Either<Failure, DeleteOrderJualBonusDetailResponse>> setDeleteOrderJualBonusDetail({
    required final String action,
    required final int dihapusoleh,
    required int nomor,
  }) async {
    try {
      final payload = DeleteOrderJualBonusDetailPayload(
        action: action,
        dihapusoleh: dihapusoleh,
      );
      final HttpResponse<dynamic> response = await api.deleteOrderJualBonusDetail(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, DeleteOrderJualBonusDetailResponse>(
          DeleteOrderJualBonusDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<DeleteOrderJualBonusDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<DeleteOrderJualBonusDetailResponse>().handleError(e);
    }
  }
}
