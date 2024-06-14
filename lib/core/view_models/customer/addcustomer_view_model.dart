import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/networks/create_customer_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCustomerViewModel extends BaseViewModel {
  AddCustomerViewModel({
    required GetDataDTOService getDataDTOApi,
    required SetCustomerDTOService setCustomerDTOApi,
  })  : _getDataDTOApi = getDataDTOApi,
        _setCustomerDTOApi = setCustomerDTOApi;

  final GetDataDTOService _getDataDTOApi;
  final SetCustomerDTOService _setCustomerDTOApi;

  final TextEditingController nomormhdesaController = TextEditingController();
  final TextEditingController nomormhkelurahanController = TextEditingController();
  final TextEditingController nomormhkecamatanController = TextEditingController();
  final TextEditingController nomormhkotaController = TextEditingController();
  final TextEditingController nomormhprovinsiController = TextEditingController();
  final TextEditingController nomormhgelarController = TextEditingController();
  final TextEditingController nomormhsalesController = TextEditingController();
  final TextEditingController nomormhkategoricustomerController = TextEditingController();
  final TextEditingController nomormhtipeoutletController = TextEditingController();
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController nomormnamaControllerhtipeoutletController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jatuhtempoController = TextEditingController();
  final TextEditingController plafonController = TextEditingController();
  final TextEditingController formatcodeController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController alamatktpController = TextEditingController();
  final TextEditingController sharelocController = TextEditingController();
  final TextEditingController notelpController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();
  final TextEditingController nonpwpController = TextEditingController();
  final TextEditingController kontakController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController dibuatolehController = TextEditingController();

  List<GetDataContent> _kategoricustomer = [];
  List<GetDataContent> get kategoricustomer => _kategoricustomer;
  GetDataContent? _selectedKategoriCustomer;
  GetDataContent? get selectedKategoriCustomer => _selectedKategoriCustomer;

  List<GetDataContent> _tipeoutlet = [];
  List<GetDataContent> get tipeoutlet => _tipeoutlet;
  GetDataContent? _selectedTipeOutlet;
  GetDataContent? get selectedTipeOutlet => _selectedTipeOutlet;

  List<GetDataContent> _gelar = [];
  List<GetDataContent> get gelar => _gelar;
  GetDataContent? _selectedGelar;
  GetDataContent? get selectedGelar => _selectedGelar;

  final List<GetDataContent> _sales = [];
  List<GetDataContent> get sales => _sales;
  GetDataContent? _selectedSales;
  GetDataContent? get selectedSales => _selectedSales;

  final List<GetDataContent> _desa = [];
  List<GetDataContent> get desa => _desa;
  GetDataContent? _selectedDesa;
  GetDataContent? get selectedDesa => _selectedDesa;

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

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchKategoriCustomer();
    await _fetchTipeOutlet();
    await _fetchGelar();
    await _fecthUser();
    setBusy(false);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchDesa();
    setisLoadingMore(false);
  }

  Future<void> _fetchKategoriCustomer() async {
    final filters = GetFilter(
      limit: 100,
    );
    final search = GetSearch(
      term: 'like',
      key: 'mhkategoricustomer.nama',
      query: searchQuery,
    );

    final response = await _getDataDTOApi.getData(
      action: "getKategoriCustomer",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _kategoricustomer = response.right.data.data;
      notify();
    }
  }

  Future<void> _fetchTipeOutlet() async {
    final filters = GetFilter(
      limit: 100,
    );

    final search = GetSearch(
      term: 'like',
      key: 'mhtipeoutlet.nama',
      query: '',
    );
    final response = await _getDataDTOApi.getData(
      action: "getTipeOutlet",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _tipeoutlet = response.right.data.data;
      notify();
    }
  }

  Future<void> _fetchGelar() async {
    final filters = GetFilter(
      limit: 100,
    );

    final search = GetSearch(
      term: 'like',
      key: 'mhgelar.nama',
      query: '',
    );

    final response = await _getDataDTOApi.getData(
      action: "getGelar",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _gelar = response.right.data.data;
      notify();
    }
  }

  GetFilter currentFilter = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "mhdesa.nama",
  );

  Future<void> fetchDesa({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mhdesa.nama, mhkecamatan.nama, mhkota.nama, mhprovinsi.nama',
      concat: 1,
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _desa.clear();
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
        action: "getDesa",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> desaDataFromApi = response.right.data.data;
        _isLastPage = desaDataFromApi.length < currentFilter.limit;

        _desa.addAll(desaDataFromApi);
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

  void setselectedkategori(GetDataContent? kategori) {
    _selectedKategoriCustomer = kategori;
    notify();
  }

  void setselectedtipeoutlet(GetDataContent? tipeoutlet) {
    _selectedTipeOutlet = tipeoutlet;
    notify();
  }

  void setselectedgelar(GetDataContent? gelar) {
    _selectedGelar = gelar;
    notify();
  }

  void setselectedsales(GetDataContent? sales) {
    _selectedSales = sales;
    notify();
  }

  void setselecteddesa(GetDataContent? desa) {
    _selectedDesa = desa;
    notify();
  }

  Future<bool> addCustomertModel({
    required int nomormhkelurahan,
    required int nomormhkecamatan,
    required int nomormhkota,
    required int nomormhprovinsi,
    required int jenis,
    required String kode,
    required String nama,
    required String jatuhtempo,
    required String plafon,
    required String formatcode,
    required String alamat,
    required String alamatktp,
    required String shareloc,
    required String nohp,
    required String hp,
    required String ktp,
    required String npwp,
    required String kontak,
    required String keterangan,
    required int dibuatoleh,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setCustomerDTOApi.setCustomer(
      action: "addCustomer",
      nomormhdesa: _selectedDesa?.nomor ?? 0,
      nomormhkelurahan: nomormhkelurahan,
      nomormhkecamatan: nomormhkecamatan,
      nomormhkota: nomormhkota,
      nomormhprovinsi: nomormhprovinsi,
      nomormhgelar: _selectedGelar?.nomor ?? 0,
      nomormhrelasisales: json.decode(userDataJson!)['nomor'],
      nomormhkategoricustomer: _selectedKategoriCustomer?.nomor ?? 0,
      nomormhtipeoutlet: _selectedTipeOutlet?.nomor ?? 0,
      jenis: jenis,
      kode: kode,
      nama: nama,
      jatuhtempo: jatuhtempo,
      plafon: plafon,
      formatcode: formatcode,
      alamat: alamat,
      alamatktp: alamatktp,
      shareloc: shareloc,
      nohp: nohp,
      hp: hp,
      ktp: ktp,
      npwp: npwp,
      kontak: kontak,
      keterangan: keterangan,
      dibuatoleh: json.decode(userDataJson)['nomor'],
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
