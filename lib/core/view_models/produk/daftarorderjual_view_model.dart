import 'package:flutter/material.dart';
import 'package:mjk_apps/core/models/get_data/produk_get_data_dto.dart';
import 'package:mjk_apps/core/networks/barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class DaftarOrderJualViewModel extends BaseViewModel {
  DaftarOrderJualViewModel({
    required BarangGetDataDTOService barangGetDataDTOApi,
  }) : _barangGetDataDTOApi = barangGetDataDTOApi;

  final BarangGetDataDTOService _barangGetDataDTOApi;

  final List<BarangGetDataContent> _barang = [];
  List<BarangGetDataContent> get barang => _barang;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  String searchQuery = '';

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchBarang(reload: true);
    setBusy(false);
  }

  BarangGetFilter currentFilter = BarangGetFilter(
    limit: 10,
    page: 1,
  );
  Future<void> fetchBarang({bool reload = false}) async {
    final search = BarangGetSearch(
      term: 'like',
      key: 'mhbarang.nama',
      query: searchQuery,
    );
    if (reload) {
      _currentPage = 1;
      _barang.clear();
    }
    try {
      final newFilter = BarangGetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
      );

      final response = await _barangGetDataDTOApi.getData(
        action: "getBarang",
        filters: newFilter,
        search: search,
        sort: "DESC",
        orderby: "mhbarang.nomor",
      );

      if (response.isRight) {
        final List<BarangGetDataContent> barangDataFromApi = response.right.data.data;
        _isLastPage = barangDataFromApi.length < currentFilter.limit;
        _barang.addAll(barangDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
      }
      debugPrint('response = ${response.left}');
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
