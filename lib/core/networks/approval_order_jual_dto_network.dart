import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/approval_order_jual_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/approval_order_jual_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setApprovalOrderJualDTOApi = Provider<SetApprovalOrderJualDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetApprovalOrderJualDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetApprovalOrderJualDTOService {
  SetApprovalOrderJualDTOService(
    Dio dio,
  ) : api = SetApprovalOrderJualDTOApi(
          dio,
        );
  final SetApprovalOrderJualDTOApi api;

  Future<Either<Failure, ApprovalOrderJualResponse>> setApprovalOrderJual({
    required String action,
    required int statusdisetujui,
    required int disetujuioleh,
    required int nomor,
  }) async {
    try {
      final requestData = ApprovalOrderJualRequest(
        statusdisetujui: statusdisetujui,
        disetujuioleh: disetujuioleh,
      );
      final payload = ApprovalOrderJualPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.approvalOrderJual(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, ApprovalOrderJualResponse>(
          ApprovalOrderJualResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<ApprovalOrderJualResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<ApprovalOrderJualResponse>().handleError(e);
    }
  }
}
