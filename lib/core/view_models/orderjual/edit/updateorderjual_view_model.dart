import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:sru/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:sru/core/networks/delete_order_jual_detail_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/networks/order_jual_get_data_dto_network.dart';
import 'package:sru/core/networks/update_order_jual_only_dto.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateOrderJualViewModel extends BaseViewModel {
  UpdateOrderJualViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
    required GetDataDTOService getDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required SetUpdateOrderJualOnlyDTOService setUpdateOrderJualOnlyDTOApi,
    required SetDeleteOrderJualDetailDTOService setDeleteOrderJualDetailDTOApi,
    required int nomor,
  })  : _orderJualGetDataDTOApi = orderJualGetDataDTOApi,
        _getDataDTOApi = getDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _setUpdateOrderJualOnlyDTOApi = setUpdateOrderJualOnlyDTOApi,
        _setDeleteOrderJualDetailDTOApi = setDeleteOrderJualDetailDTOApi,
        _nomor = nomor;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;
  final GetDataDTOService _getDataDTOApi;
  // ignore: unused_field
  final SharedPreferencesService _sharedPreferencesService;
  final SetUpdateOrderJualOnlyDTOService _setUpdateOrderJualOnlyDTOApi;
  final SetDeleteOrderJualDetailDTOService _setDeleteOrderJualDetailDTOApi;
  final int _nomor;

  final TextEditingController kodeController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayalainController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  int _subtotal = 0;
  int _diskonnominal = 0;
  int _dpp = 0;
  int _ppn = 0;
  int _biayalain = 0;
  int _total = 0;

  OrderJualGetDataContent? _orderjual;
  OrderJualGetDataContent? get orderjual => _orderjual;

  List<OrderJualGetDataContent> _orderjualdetail = [];
  List<OrderJualGetDataContent> get orderjualdetail => _orderjualdetail;

  final List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  final List<GetDataContent> _customer = [];
  List<GetDataContent> get customer => _customer;
  GetDataContent? _selectedCustomer;
  GetDataContent? get selectedCustomer => _selectedCustomer;

  final List<GetDataContent> _sales = [];
  List<GetDataContent> get sales => _sales;
  GetDataContent? _selectedSales;
  GetDataContent? get selectedSales => _selectedSales;

  int get selectedPPN => _selectedPPN;
  int _selectedPPN = 0;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  // ignore: unused_field
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  late DateTime selectedDate;

  void setLoading(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _isLoadingMore = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  void hitung() {
    double disc1Percentage = (double.tryParse(diskonprosentaseController.text) ?? 0) / 100;

    _subtotal = int.parse(subtotalController.text);
    debugPrint('totalSubtotal $_subtotal');

    _diskonnominal = (_subtotal * disc1Percentage).toInt();
    diskonnominalController.text = _diskonnominal.toString();
    if (selectedPPN == '0') {
      _ppn = 0;
    } else {
      _ppn = (_dpp * 0.11).toInt();
    }
    _dpp = _subtotal - _diskonnominal.toInt();
    dppController.text = _dpp.toString();
    ppnnominalController.text = _ppn.toString();
    debugPrint('dpp : $_dpp');
    debugPrint('ppn : $_ppn');
    _biayalain = 0;
    debugPrint('biayalain : $_biayalain');
    _total = _dpp + _ppn + _biayalain;
    totalController.text = _total.toString();
    notifyListeners();
  }

  void hitung2() {
    _dpp = int.parse(dppController.text);
    debugPrint('dpp : $_dpp');
    _ppn = int.parse(ppnnominalController.text);
    debugPrint('ppn : $_ppn');
    _biayalain = int.parse(biayalainController.text);
    _total = _dpp + _ppn + _biayalain;
    totalController.text = _total.toString();
    notifyListeners();
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
    await fetchOrderJual(reload: true);
    await _fetchOrderJualDetail(_nomor);
    await _fecthUser();
    setBusy(false);
    diskonprosentaseController.addListener(hitung);
    subtotalController.addListener(hitung);
    biayalainController.addListener(hitung2);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchCustomer();
    setisLoadingMore(false);
  }

  OrderJualGetFilter currentOrderJualFilter = OrderJualGetFilter(
    limit: 10,
    page: 10,
  );
  Future<void> fetchOrderJual({bool reload = false}) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'thorderjual.kode',
      query: '',
    );
    if (reload) {
      _currentPage = 1;
    }
    try {
      final newFilter = OrderJualGetFilter(
        limit: currentOrderJualFilter.limit,
        page: _currentPage,
        sort: 'DESC',
        nomor: _nomor,
        orderby: 'thorderjual.nomor',
      );

      final response = await _orderJualGetDataDTOApi.getData(
        action: "getOrderJual",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        _orderjual = response.right.data.data[0];
        kodeController.text = _orderjual?.kode ?? '';
        customerController.text = _orderjual?.customer ?? '';
        diskonprosentaseController.text = _orderjual?.diskonprosentase.toString() ?? '';
        diskonnominalController.text = _orderjual?.diskonnominal.toString() ?? '';
        dppController.text = _orderjual?.dpp.toString() ?? '';
        ppnnominalController.text = _orderjual?.ppnnominal.toString() ?? '';
        biayalainController.text = _orderjual?.totalbiaya.toString() ?? '';
        totalController.text = _orderjual?.total.toString() ?? '';
        subtotalController.text = _orderjual?.subtotal2.toString() ?? '';
        selectedDate = DateTime.parse(_orderjual?.tanggal ?? '');
        setselectedPPN(_orderjual?.statusppn ?? 0);
        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _fetchOrderJualDetail(int nomorOrderJual) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'tdorderjual.nomorthorderjual',
      query: '$nomorOrderJual',
    );
    debugPrint('nomororderjual $nomorOrderJual');
    final filters = OrderJualGetFilter(
      limit: 10,
      page: 1,
    );

    final response = await _orderJualGetDataDTOApi.getData(
      action: "getOrderJualDetail",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _orderjualdetail = response.right.data.data;
      notify();
    } else {}
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

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    customerController.text = customer?.nama ?? '';
    notify();
  }

  void setselectedsales(GetDataContent? sales) {
    _selectedSales = sales;
    notify();
  }

  void setselectedPPN(int value) {
    _selectedPPN = value;
    notify();
  }

  Future<bool> updateOrderJualOnlyModel({
    required String nomormhrelasicust,
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
    required int dibuatoleh,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setUpdateOrderJualOnlyDTOApi.seUpdatetOrderJual(
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
      diubaholeh: json.decode(userDataJson)['nomor'],
      nomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> deleteOrderJualDetailModel({
    required int dihapusoleh,
    required int nomor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setDeleteOrderJualDetailDTOApi.setDeleteOrderJualDetail(
      action: "softDeleteOrderJualDetail",
      dihapusoleh: json.decode(userDataJson!)['nomor'],
      nomor: nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
