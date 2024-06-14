import 'package:flutter/material.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/models/get_data/kunjungan_get_data_dto.dart';
import 'package:mjk_apps/core/networks/kunjungan_get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class ListPelangganViewModel extends BaseViewModel {
  ListPelangganViewModel({
    required KunjunganGetDataDTOService kunjunganGetDataDTOApi,
  }) : _kunjunganGetDataDTOApi = kunjunganGetDataDTOApi;

  final KunjunganGetDataDTOService _kunjunganGetDataDTOApi;

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

  String _currentSearchKey = 'thkunjungan.kode'; // Default search key
  String get currentSearchKey => _currentSearchKey;
  Future<void> fetchPelanggan({bool reload = false, String? searchKey}) async {
    final search = KunjunganGetSearch(
      term: 'like',
      key: searchKey ?? _currentSearchKey,
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

  void updateSearchKey(String newSearchKey) {
    _currentSearchKey = newSearchKey;
    // Fetch data with new search key
    fetchPelanggan(reload: true, searchKey: _currentSearchKey);
  }
}
