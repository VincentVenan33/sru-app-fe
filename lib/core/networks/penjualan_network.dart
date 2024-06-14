import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/apis/penjualan_api.dart';
import 'package:sru/core/models/authentication/login.dart';
import 'package:sru/core/models/parsed_response.dart';
import 'package:sru/core/models/penjualan/approval_order_penjualan.dart';
import 'package:sru/core/services/dio_service.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/utilities/error_utils.dart';
import 'package:retrofit/dio.dart';

final penjualanApi = Provider<PenjualanApiService>((ref) {
  final SharedPreferencesService sharedPref = ref.read(sharedPrefProvider);
  final DioService dio = ref.read(dioProvider);
  return PenjualanApiService(
    dio.getDio(domainType: DomainType.account),
    sharedPref,
  );
});

class PenjualanApiService {
  PenjualanApiService(
    Dio dio,
    this.sharedPref,
  ) : api = PenjualanApi(
          dio,
        );
  final SharedPreferencesService sharedPref;
  final PenjualanApi api;

  Future<Either<Failure, GetOrderJualsResponse>> getOrderJuals({
    required String tanggal,
  }) async {
    try {
      final LoginResponseData? userData = await sharedPref.get(SharedPrefKeys.tokenLogin);

      final HttpResponse<dynamic> response = await api.getOrderJuals(
        'application/json',
        userData?.token ?? '',
        userData?.user.nomor ?? 1,
        tanggal,
      );
      if (response.isSuccess) {
        return Right<Failure, GetOrderJualsResponse>(
          GetOrderJualsResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<GetOrderJualsResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<GetOrderJualsResponse>().handleError(e);
    }
  }

  Future<Either<Failure, ApproveOrderJualResponse>> approveOrderJual({
    required int nomorThOrderJual,
  }) async {
    try {
      final LoginResponseData? userData = await sharedPref.get(SharedPrefKeys.tokenLogin);

      final payload = ApproveOrderJualRequest(
        nomorthorderjual: nomorThOrderJual,
        nomoruser: userData?.user.nomor ?? 1,
      );

      final HttpResponse<dynamic> response = await api.approveOrderJual(
        'application/json',
        userData?.token ?? '',
        userData?.user.nomor ?? 1,
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, ApproveOrderJualResponse>(
          ApproveOrderJualResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<ApproveOrderJualResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<ApproveOrderJualResponse>().handleError(e);
    }
  }

  // Future<Either<Failure, LoginResponse>> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   try {
  //     final payload = LoginRequest(
  //       username: username,
  //       password: password,
  //     );
  //     final HttpResponse<dynamic> response = await api.login(
  //       'application/json',
  //       payload,
  //     );
  //     if (response.isSuccess) {
  //       return Right<Failure, LoginResponse>(
  //         LoginResponse.fromJson(
  //           response.data,
  //         ),
  //       );
  //     }
  //     return ErrorUtils<LoginResponse>().handleDomainError(
  //       response,
  //     );
  //   } catch (e) {
  //     return ErrorUtils<LoginResponse>().handleError(e);
  //   }
  // }
}
