import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/update_customer_dto.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCustomerViewModel extends BaseViewModel {
  UpdateCustomerViewModel({
    required GetDataDTOService getDataDTOApi,
    required SetUpdateCustomerDTOService setUpdateCustomerDTOApi,
    required int nomor,
  })  : _getDataDTOApi = getDataDTOApi,
        _setUpdateCustomerDTOApi = setUpdateCustomerDTOApi,
        _nomor = nomor;

  final GetDataDTOService _getDataDTOApi;
  final SetUpdateCustomerDTOService _setUpdateCustomerDTOApi;
  final int _nomor;

  final TextEditingController nomormhdesaController = TextEditingController();
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
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController desaController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController alamatktpController = TextEditingController();
  final TextEditingController sharelocController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();
  // final TextEditingController npwpController = TextEditingController();
  final npwpController = MaskedTextController(mask: '00.000.000.0-000.000');
  final TextEditingController kontakController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController diubaholehController = TextEditingController();

  final List<GetDataContent> _daftarcustomer = [];
  List<GetDataContent> get daftarcustomer => _daftarcustomer;

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
    await fetchDaftarCustomer(reload: true);
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

  GetFilter currentFilterCustomer = GetFilter(
    limit: 10,
    sort: 'ASC',
    orderby: 'mhrelasi.nomor',
  );
  Future<void> fetchDaftarCustomer({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mhrelasi.nama',
      query: searchQuery,
    );
    if (reload) {
      _currentPage = 1;
      _daftarcustomer.clear();
      // searchQuery = '';
    }
    try {
      final newFilter = GetFilter(
        limit: currentFilterCustomer.limit,
        page: _currentPage,
        sort: currentFilterCustomer.sort,
        orderby: currentFilterCustomer.orderby,
        nomor: _nomor,
      );

      final response = await _getDataDTOApi.getData(
        action: "getCustomer",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> customerDataFromApi = response.right.data.data;
        _isLastPage = customerDataFromApi.length < currentFilter.limit;
        _daftarcustomer.addAll(customerDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }
        namaController.text = _daftarcustomer[0].nama;
        alamatController.text = _daftarcustomer[0].alamat ?? '';
        desaController.text = _daftarcustomer[0].desa ?? '';
        kotaController.text = _daftarcustomer[0].kota ?? '';
        kecamatanController.text = _daftarcustomer[0].kecamatan ?? '';
        provinsiController.text = _daftarcustomer[0].provinsi ?? '';
        nohpController.text = _daftarcustomer[0].nohp ?? '';
        ktpController.text = _daftarcustomer[0].ktp ?? '';
        alamatktpController.text = _daftarcustomer[0].alamatktp ?? '';
        jatuhtempoController.text = _daftarcustomer[0].jatuhtempo.toString();
        npwpController.text = _daftarcustomer[0].npwp ?? '';
        kontakController.text = _daftarcustomer[0].kontak ?? '';
        plafonController.text = _daftarcustomer[0].plafon.toString();
        keteranganController.text = _daftarcustomer[0].keterangan ?? '';
        notify();
        await _fetchDesa(nomor: _daftarcustomer[0].nomormhdesa.toString());
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
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

  Future<void> _fetchDesa({String? nomor}) async {
    final search = GetSearch(
      term: 'equal',
      key: 'mhdesa.nomor',
      query: nomor,
    );

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

        _desa.addAll(desaDataFromApi);

        notify();
        setBusy(false);
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
    desaController.text = desa?.nama ?? '';
    kotaController.text = desa?.kota ?? '';
    kecamatanController.text = desa?.kecamatan ?? '';
    provinsiController.text = desa?.provinsi ?? '';
    notify();
  }

  Future<bool> updateCustomertModel({
    required int nomormhkecamatan,
    required int nomormhkota,
    required int nomormhprovinsi,
    required int jenis,
    required String nama,
    required String jatuhtempo,
    required String plafon,
    required String alamat,
    required String alamatktp,
    required String shareloc,
    required String nohp,
    required String hp,
    required String ktp,
    required String npwp,
    required String kontak,
    required String keterangan,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setUpdateCustomerDTOApi.setUpdateCustomer(
      action: "updateCustomer",
      nomormhdesa: _selectedDesa?.nomor ?? 0,
      nomormhkecamatan: nomormhkecamatan,
      nomormhkota: nomormhkota,
      nomormhprovinsi: nomormhprovinsi,
      nomormhgelar: _selectedGelar?.nomor ?? 0,
      nomormhrelasisales: json.decode(userDataJson!)['nomor'],
      nomormhkategoricustomer: _selectedKategoriCustomer?.nomor ?? 0,
      nomormhtipeoutlet: _selectedTipeOutlet?.nomor ?? 0,
      jenis: jenis,
      nama: nama,
      jatuhtempo: jatuhtempo,
      plafon: plafon,
      alamat: alamat,
      alamatktp: alamatktp,
      shareloc: shareloc,
      nohp: nohp,
      hp: hp,
      ktp: ktp,
      npwp: npwp,
      kontak: kontak,
      keterangan: keterangan,
      diubaholeh: json.decode(userDataJson)['nomor'],
      nomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
