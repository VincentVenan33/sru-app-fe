import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/utilities/error_utils.dart';

import '../apis/produk_api.dart';
import '../models/produk/produk.dart';

final produkApi = Provider<ProdukApiService>((ref) {
  final SharedPreferencesService sharedPref = ref.read(sharedPrefProvider);
  final DioService dio = ref.read(dioProvider);
  return ProdukApiService(
    dio.getDio(domainType: DomainType.account),
    sharedPref,
  );
});

class ProdukApiService {
  ProdukApiService(
    Dio dio,
    this.sharedPref,
  ) : api = ProdukApi(
          dio,
        );
  final SharedPreferencesService sharedPref;
  final ProdukApi api;

  Future<Either<Failure, GetProdukResponse>> getProduk({
    required String tanggal,
  }) async {
    try {
      // final LoginResponseData? userData = await sharedPref.get(SharedPrefKeys.tokenLogin);

      final HttpResponse<dynamic> response = await api.getproduk(
        'application/json',
        // userData?.tokenLogin ?? '',
        // userData?.user.nomor ?? 1,
        // tanggal,
      );
      if (response.isSuccess) {
        return Right<Failure, GetProdukResponse>(
          GetProdukResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<GetProdukResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<GetProdukResponse>().handleError(e);
    }
  }
}
