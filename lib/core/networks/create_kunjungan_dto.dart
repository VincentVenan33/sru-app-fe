import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/create_kunjungan_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/create_kunjungan_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setKunjunganDTOApi = Provider<SetKunjunganDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetKunjunganDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetKunjunganDTOService {
  SetKunjunganDTOService(
    Dio dio,
  ) : api = CreateKunjunganDTOApi(
          dio,
        );
  final CreateKunjunganDTOApi api;

  Future<Either<Failure, CreateKunjunganResponse>> setKunjungan({
    required String action,
    required String formatcode,
    required String kode,
    required int nomormhcustomer,
    required int nomormhsales,
    required String tanggal,
    required String waktuin,
    required String waktuout,
    required String judul,
    required String rencana,
    required String gambar,
    required double? latitude,
    required double? longitude,
  }) async {
    try {
      final requestData = CreateKunjunganRequest(
        formatcode: formatcode,
        kode: kode,
        nomormhcustomer: nomormhcustomer,
        nomormhsales: nomormhsales,
        tanggal: tanggal,
        waktuin: waktuin,
        waktuout: waktuout,
        judul: judul,
        rencana: rencana,
        gambar: gambar,
        latitude: latitude,
        longitude: longitude,
      );
      final payload = CreateKunjunganPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.createKunjungan(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, CreateKunjunganResponse>(
          CreateKunjunganResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<CreateKunjunganResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<CreateKunjunganResponse>().handleError(e);
    }
  }
}
