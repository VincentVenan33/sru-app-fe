import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/update_customer_dto_api.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/set_data/update_customer_dto.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final setUpdateCustomerDTOApi = Provider<SetUpdateCustomerDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateCustomerDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateCustomerDTOService {
  SetUpdateCustomerDTOService(
    Dio dio,
  ) : api = SetUpdateCustomerDTOApi(
          dio,
        );
  final SetUpdateCustomerDTOApi api;

  Future<Either<Failure, UpdateCustomerResponse>> setUpdateCustomer({
    required String action,
    required int nomormhdesa,
    required int nomormhkategoricustomer,
    required int nomormhtipeoutlet,
    required int nomormhgelar,
    required int nomormhrelasisales,
    required int nomormhprovinsi,
    required int nomormhkota,
    required int nomormhkecamatan,
    required int jenis,
    required String nama,
    required String jatuhtempo,
    required String plafon,
    required String alamat,
    required String alamatktp,
    required String shareloc,
    required String nohp,
    required String hp,
    required String ktp,
    required String npwp,
    required String kontak,
    required String? keterangan,
    required int diubaholeh,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateRequest(
        nomormhdesa: nomormhdesa,
        nomormhkategoricustomer: nomormhkategoricustomer,
        nomormhtipeoutlet: nomormhtipeoutlet,
        nomormhgelar: nomormhgelar,
        nomormhrelasisales: nomormhrelasisales,
        nomormhprovinsi: nomormhprovinsi,
        nomormhkota: nomormhkota,
        nomormhkecamatan: nomormhkecamatan,
        jenis: jenis,
        nama: nama,
        jatuhtempo: jatuhtempo,
        plafon: plafon,
        alamat: alamat,
        alamatktp: alamatktp,
        shareloc: shareloc,
        nohp: nohp,
        hp: hp,
        ktp: ktp,
        kontak: kontak,
        npwp: npwp,
        keterangan: keterangan,
        diubaholeh: diubaholeh,
      );
      final payload = UpdateCustomerPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.updateCustomer(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateCustomerResponse>(
          UpdateCustomerResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateCustomerResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateCustomerResponse>().handleError(e);
    }
  }
}
