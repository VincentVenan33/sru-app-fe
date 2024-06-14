import 'package:flutter/material.dart';
import 'package:mjk_apps/core/models/get_data/produk_get_data_dto.dart';
import 'package:mjk_apps/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class DetailOrderJualViewModel extends BaseViewModel {
  DetailOrderJualViewModel({
    required BarangGetDataDTOService barangGetDataDTOApi,
    required SatuanBarangGetDataDTOService satuanBarangGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required int nomor,
  })  : _barangGetDataDTOApi = barangGetDataDTOApi,
        _satuanBarangGetDataDTOApi = satuanBarangGetDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _nomor = nomor;

  final BarangGetDataDTOService _barangGetDataDTOApi;
  final SatuanBarangGetDataDTOService _satuanBarangGetDataDTOApi;
  final SharedPreferencesService _sharedPreferencesService;
  final int _nomor;

  final List<BarangGetDataContent> _barang = [];
  List<BarangGetDataContent> get barang => _barang;

  List<SatuanBarangGetDataContent> _satuanbarang = [];
  List<SatuanBarangGetDataContent> get satuanbarang => _satuanbarang;
  SatuanBarangGetDataContent? _selectedSatuanBarang;
  SatuanBarangGetDataContent? get selectedSatuanBarang => _selectedSatuanBarang;

  List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchBarang(reload: true);
    await _fetchSatuanBarang(_nomor);
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
      query: '',
    );
    if (reload) {
      _currentPage = 1;
      _barang.clear();
    }
    try {
      final newFilter = BarangGetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
        nomor: _nomor,
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
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _fetchSatuanBarang(int nomorBarang) async {
    final filters = SatuanBarangGetFilter(
      query: nomorBarang,
    );
    debugPrint('nomorBarang $nomorBarang');
    final response = await _satuanBarangGetDataDTOApi.getData(
      action: "getSatuanBarang",
      filters: filters,
    );

    if (response.isRight) {
      _satuanbarang = response.right.data;
      notify();
    }
  }

  void setselectedsatuanBarang(SatuanBarangGetDataContent? satuanbarang) {
    _selectedSatuanBarang = satuanbarang;
    notify();
  }

  Future<bool> addItemtoList(CreateOrderJualDetailRequest detailItemParam) async {
    final ListDetailItem? detailItem = await _sharedPreferencesService.get(
      SharedPrefKeys.detailItemOrderJual,
    );
    _detailItems = detailItem?.items ?? [];
    _detailItems.add(detailItemParam);
    _sharedPreferencesService.set(
      SharedPrefKeys.detailItemOrderJual,
      ListDetailItem(
        items: _detailItems,
      ),
    );
    return true;
  }
}
