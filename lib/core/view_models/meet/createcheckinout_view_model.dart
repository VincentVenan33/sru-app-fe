import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/networks/create_kunjungan_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCheckInOutViewModel extends BaseViewModel {
  AddCheckInOutViewModel({
    required GetDataDTOService getDataDTOApi,
    required SetKunjunganDTOService setKunjunganDTOApi,
  })  : _getDataDTOApi = getDataDTOApi,
        _setKunjunganDTOApi = setKunjunganDTOApi;

  final GetDataDTOService _getDataDTOApi;
  final SetKunjunganDTOService _setKunjunganDTOApi;

  final TextEditingController kodeController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController waktuinController = TextEditingController();
  final TextEditingController waktuoutController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController rencanaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

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
    limit: 5,
    sort: "ASC",
    orderby: "mhrelasi.nama",
  );

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchCustomer();
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
        // _isLoadingMore = false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      setBusy(false);
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

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    notify();
  }

  void setselectedsales(GetDataContent? sales) {
    _selectedSales = sales;
    notify();
  }

  Future<bool> addCheckInOutModel({
    required String formatcode,
    required String kode,
    required String tanggal,
    required String waktuin,
    required String waktuout,
    required String judul,
    required String rencana,
    required String gambar,
    required double latitude,
    required double longitude,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setKunjunganDTOApi.setKunjungan(
      action: "addKunjungan",
      nomormhcustomer: _selectedCustomer?.nomor ?? 0,
      nomormhsales: json.decode(userDataJson!)['nomor'],
      kode: kode,
      tanggal: tanggal,
      waktuin: waktuin,
      waktuout: waktuout,
      formatcode: formatcode,
      judul: judul,
      rencana: rencana,
      gambar: gambar,
      latitude: latitude,
      longitude: longitude,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
