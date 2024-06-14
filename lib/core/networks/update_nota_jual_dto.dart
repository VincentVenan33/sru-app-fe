import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/update_nota_jual_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/update_nota_jual_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setUpdateNotaJualDTOApi = Provider<SetUpdateNotaJualDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateNotaJualDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateNotaJualDTOService {
  SetUpdateNotaJualDTOService(
    Dio dio,
  ) : api = UpdateNotaJualDTOApi(
          dio,
        );
  final UpdateNotaJualDTOApi api;

  Future<Either<Failure, UpdateNotaJualResponse>> setUpdateNotaJual({
    required final String action,
    required final double? latitude,
    required final double? longitude,
    required final String mode,
    required final int nomormhadmin,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateNotaJualRequest(
        latitude: latitude,
        longitude: longitude,
        mode: mode,
        nomormhadmin: nomormhadmin,
      );
      final payload = UpdateNotaJualPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.updateNotaJual(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateNotaJualResponse>(
          UpdateNotaJualResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateNotaJualResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateNotaJualResponse>().handleError(e);
    }
  }
}
