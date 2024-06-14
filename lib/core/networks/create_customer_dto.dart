import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/apis/create_customer_dto_api.dart';
import 'package:mjk_apps/core/models/parsed_response.dart';
import 'package:mjk_apps/core/models/set_data/create_customer_dto.dart';
import 'package:mjk_apps/core/services/dio_service.dart';
import 'package:mjk_apps/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setCustomerDTOApi = Provider<SetCustomerDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetCustomerDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetCustomerDTOService {
  SetCustomerDTOService(
    Dio dio,
  ) : api = SetCustomerDTOApi(
          dio,
        );
  final SetCustomerDTOApi api;

  Future<Either<Failure, CreateCustomerResponse>> setCustomer({
    required String action,
    required int nomormhdesa,
    required int nomormhkategoricustomer,
    required int nomormhtipeoutlet,
    required int nomormhgelar,
    required int nomormhrelasisales,
    required int nomormhkelurahan,
    required int nomormhprovinsi,
    required int nomormhkota,
    required int nomormhkecamatan,
    required int jenis,
    required String kode,
    required String nama,
    required String jatuhtempo,
    required String plafon,
    required String formatcode,
    required String alamat,
    required String alamatktp,
    required String shareloc,
    required String nohp,
    required String hp,
    required String ktp,
    required String npwp,
    required String kontak,
    required String? keterangan,
    required int dibuatoleh,
  }) async {
    try {
      final requestData = CreateRequest(
        nomormhdesa: nomormhdesa,
        nomormhkategoricustomer: nomormhkategoricustomer,
        nomormhtipeoutlet: nomormhtipeoutlet,
        nomormhgelar: nomormhgelar,
        nomormhrelasisales: nomormhrelasisales,
        nomormhkelurahan: nomormhkelurahan,
        nomormhprovinsi: nomormhprovinsi,
        nomormhkota: nomormhkota,
        nomormhkecamatan: nomormhkecamatan,
        jenis: jenis,
        kode: kode,
        nama: nama,
        jatuhtempo: jatuhtempo,
        plafon: plafon,
        formatcode: formatcode,
        alamat: alamat,
        alamatktp: alamatktp,
        shareloc: shareloc,
        nohp: nohp,
        hp: hp,
        ktp: ktp,
        npwp: npwp,
        kontak: kontak,
        keterangan: keterangan,
        dibuatoleh: dibuatoleh,
      );
      final payload = CreateCustomerPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.createCustomer(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, CreateCustomerResponse>(
          CreateCustomerResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<CreateCustomerResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<CreateCustomerResponse>().handleError(e);
    }
  }
}
