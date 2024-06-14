import 'package:flutter/material.dart';
import 'package:sru/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:sru/core/models/set_data/create_order_jual_dto.dart';
import 'package:sru/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';

class EditDetailOrderJualViewModel extends BaseViewModel {
  EditDetailOrderJualViewModel({
    required SatuanBarangGetDataDTOService satuanBarangGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    CreateOrderJualDetailRequest? detailitem,
    required int nomor,
    int? index,
  })  : _satuanBarangGetDataDTOApi = satuanBarangGetDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _detailitem = detailitem,
        _nomor = nomor,
        _index = index;

  final SatuanBarangGetDataDTOService _satuanBarangGetDataDTOApi;
  final SharedPreferencesService _sharedPreferencesService;
  final CreateOrderJualDetailRequest? _detailitem;
  // ignore: unused_field
  final int _nomor;
  // ignore: unused_field
  final int? _index;

  List<SatuanBarangGetDataContent> _satuanbarang = [];
  List<SatuanBarangGetDataContent> get satuanbarang => _satuanbarang;
  SatuanBarangGetDataContent? _selectedSatuanBarang;
  SatuanBarangGetDataContent? get selectedSatuanBarang => _selectedSatuanBarang;

  List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchSatuanBarang(_detailitem?.nomormhbarang ?? 0);
    setBusy(false);
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

  Future<void> setselectedsatuanBarang(SatuanBarangGetDataContent? satuanbarang) async {
    _selectedSatuanBarang = satuanbarang;
    notify();
  }

  Future<bool> addItemtoList(int index, CreateOrderJualDetailRequest detailItemParam) async {
    final ListDetailItem? detailItem = await _sharedPreferencesService.get(
      SharedPrefKeys.detailItemOrderJual,
    );
    _detailItems = detailItem?.items ?? [];
    if (index >= 0 && index < _detailItems.length) {
      // Pastikan indeks berada dalam rentang yang benar
      _detailItems[index] = detailItemParam;
      _sharedPreferencesService.set(
        SharedPrefKeys.detailItemOrderJual,
        ListDetailItem(
          items: _detailItems,
        ),
      );
      return true;
    } else {
      return false; // Kembalikan false jika indeks tidak valid
    }
  }

  void editItemtoList(CreateOrderJualDetailRequest detailItem) {
    _detailItems.add(detailItem);
    notify();
  }
}
