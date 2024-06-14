import 'package:flutter/material.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/models/get_data/kunjungan_get_data_dto.dart';
import 'package:mjk_apps/core/networks/kunjungan_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/update_kunjungan_dto.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class DetailPelangganViewModel extends BaseViewModel {
  DetailPelangganViewModel({
    required KunjunganGetDataDTOService kunjunganGetDataDTOApi,
    required SetUpdateKunjunganDTOService setUpdateKunjunganDTOApi,
    required int nomor,
  })  : _kunjunganGetDataDTOApi = kunjunganGetDataDTOApi,
        _setUpdateKunjunganDTOApi = setUpdateKunjunganDTOApi,
        _nomor = nomor;

  final KunjunganGetDataDTOService _kunjunganGetDataDTOApi;
  final SetUpdateKunjunganDTOService _setUpdateKunjunganDTOApi;
  final int _nomor;

  final List<KunjunganGetDataContent> _kunjungan = [];
  List<KunjunganGetDataContent> get kunjungan => _kunjungan;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  String searchQuery = '';

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchPelanggan(reload: true);
    setBusy(false);
  }

  GetFilter currentFilter = GetFilter(
    limit: 10,
    sort: 'ASC',
    orderby: 'thkunjungan.nomor',
  );

  Future<void> fetchPelanggan({bool reload = false, String? searchKey}) async {
    final search = KunjunganGetSearch(
      term: 'like',
      key: 'thkunjungan.kode',
      query: searchQuery,
    );
    if (reload) {
      _currentPage = 1;
      _kunjungan.clear();
      // searchQuery = '';
    }
    try {
      final newFilter = KunjunganGetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
        sort: currentFilter.sort,
        orderby: currentFilter.orderby,
        nomor: _nomor,
      );

      final response = await _kunjunganGetDataDTOApi.getData(
        action: "getKunjungan",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<KunjunganGetDataContent> customerDataFromApi = response.right.data.data;
        _isLastPage = customerDataFromApi.length < currentFilter.limit;
        _kunjungan.addAll(customerDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<bool> updateKunjungan({
    required double longitude,
    required double latitude,
    required String mode,
  }) async {
    final response = await _setUpdateKunjunganDTOApi.setUpdateKunjungan(
      action: "updateKunjungan",
      longitude: longitude,
      latitude: latitude,
      mode: mode,
      nomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
