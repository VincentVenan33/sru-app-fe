import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/create_order_jual_detail_bonus_dto.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOrderJualViewModel extends BaseViewModel {
  AddOrderJualViewModel({
    required GetDataDTOService getDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required SetOrderJualDetailBonusDTOService setOrderJualDetailBonusDTOApi,
  })  : _getDataDTOApi = getDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _setOrderJualDetailBonusDTOApi = setOrderJualDetailBonusDTOApi;

  final GetDataDTOService _getDataDTOApi;
  final SharedPreferencesService _sharedPreferencesService;
  final SetOrderJualDetailBonusDTOService _setOrderJualDetailBonusDTOApi;

  final TextEditingController ppnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  final List<GetDataContent> _customer = [];
  List<GetDataContent> get customer => _customer;
  GetDataContent? _selectedCustomer;
  GetDataContent? get selectedCustomer => _selectedCustomer;

  final List<GetDataContent> _sales = [];
  List<GetDataContent> get sales => _sales;
  GetDataContent? _selectedSales;
  GetDataContent? get selectedSales => _selectedSales;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  // ignore: unused_field
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  void setLoading(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _isLoadingMore = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  String searchQuery = '';

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  GetFilter currentFilter = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "mhrelasi.nama",
  );

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchDetailItem();
    await _fecthUser();
    setBusy(false);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchCustomer();
    setisLoadingMore(false);
  }

  Future<void> fetchCustomer({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mhrelasi.nama',
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _customer.clear();
    } else {
      // Add this else part
      _isLoadingMore = true; // Set loading before fetching
    }
    try {
      final newFilter = GetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
        sort: currentFilter.sort,
        orderby: currentFilter.orderby,
      );

      final response = await _getDataDTOApi.getData(
        action: "getCustomer",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> customerDataFromApi = response.right.data.data;
        _isLastPage = customerDataFromApi.length < currentFilter.limit;

        _customer.addAll(customerDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
        setBusy(false);
        _isLoadingMore = false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      setBusy(false);
      _isLoadingMore = false;
    }
  }

  Future<void> _fecthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    _nama = json.decode(userDataJson!)['nama'];
    _admingrup = json.decode(userDataJson)['admingrup'];
  }

  void setisLoadingMore(bool isLoadingMore) {
    _isLoadingMore = isLoadingMore;
    notify();
  }

  Future<void> _fetchDetailItem() async {
    setBusy(true);
    final ListDetailItem? detailItem = await _sharedPreferencesService.get(
      SharedPrefKeys.detailItemOrderJual,
    );
    _detailItems = detailItem?.items ?? [];
    setBusy(false);
  }

  void addItemtoList(CreateOrderJualDetailRequest detailItem) {
    _detailItems.add(detailItem);
    notify();
  }

  void _updateSharedPreferences() {
    _sharedPreferencesService.set(
      SharedPrefKeys.detailItemOrderJual,
      ListDetailItem(
        items: _detailItems,
      ),
    );
  }

  void clearItem() {
    _detailItems.clear();
    _updateSharedPreferences();
  }

  void clearItemAtIndex(int index) {
    _detailItems.removeAt(index);
    _updateSharedPreferences();
    notify();
  }

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    notify();
  }

  void setselectedsales(GetDataContent? sales) {
    _selectedSales = sales;
    notify();
  }

  Future<bool> addOrderJualModel({
    required String nomormhcustomer,
    required String kode,
    required String ppnprosentase,
    required int statusppn,
    required int ppnnominal,
    required int diskonprosentase,
    required int diskonnominal,
    required int dpp,
    required int totalbiaya,
    required int total,
    required int subtotal2,
    required String tanggal,
    required String formatcode,
    required int dibuatoleh,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setOrderJualDetailBonusDTOApi.setOrderJual(
      action: "addOrderJual",
      nomormhrelasicust: _selectedCustomer?.nomor.toString() ?? '',
      nomormhrelasisales: json.decode(userDataJson!)['nomor'].toString(),
      kode: kode,
      ppnprosentase: ppnprosentase,
      statusppn: statusppn,
      ppnnominal: ppnnominal,
      diskonnominal: diskonnominal,
      diskonprosentase: diskonprosentase,
      dpp: dpp,
      totalbiaya: totalbiaya,
      total: total,
      subtotal2: subtotal2,
      tanggal: tanggal,
      formatcode: formatcode,
      dibuatoleh: json.decode(userDataJson)['nomor'],
      detailitem: _detailItems,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> editItemtoList(CreateOrderJualDetailRequest detailItemParam) async {
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
