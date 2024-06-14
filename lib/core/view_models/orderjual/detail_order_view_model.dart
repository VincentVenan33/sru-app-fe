import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mjk_apps/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:mjk_apps/core/networks/delete_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOrderPenjualanViewModel extends BaseViewModel {
  DetailOrderPenjualanViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
    required SetDeleteOrderJualDTOService setDeleteOrderJualDTOApi,
    required int nomor,
  })  : _orderJualGetDataDTOApi = orderJualGetDataDTOApi,
        _setDeleteOrderJualDTOApi = setDeleteOrderJualDTOApi,
        _nomor = nomor;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;
  final SetDeleteOrderJualDTOService _setDeleteOrderJualDTOApi;
  final int _nomor;

  final List<OrderJualGetDataContent> _orderjual = [];
  List<OrderJualGetDataContent> get orderjual => _orderjual;

  List<OrderJualGetDataContent> _orderjualdetail = [];
  List<OrderJualGetDataContent> get orderjualdetail => _orderjualdetail;

  List<OrderJualGetDataContent> _orderjualbonusdetail = [];
  List<OrderJualGetDataContent> get orderjualbonusdetail => _orderjualbonusdetail;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchOrderJual(reload: true);
    await _fetchOrderJualDetail(_nomor);
    await _fetchOrderJualBonusDetail(_nomor);
    setBusy(false);
  }

  OrderJualGetFilter currentFilter = OrderJualGetFilter(
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
      _orderjual.clear();
    }
    try {
      final newFilter = OrderJualGetFilter(
        limit: currentFilter.limit,
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
        final List<OrderJualGetDataContent> orderjualDataFromApi = response.right.data.data;
        _isLastPage = orderjualDataFromApi.length < currentFilter.limit;
        _orderjual.addAll(orderjualDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

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

  Future<void> _fetchOrderJualBonusDetail(int nomorOrderJual) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'tdorderjualbonus.nomorthorderjual',
      query: '$nomorOrderJual',
    );
    final filters = OrderJualGetFilter(
      limit: 10,
      page: 1,
    );

    final response = await _orderJualGetDataDTOApi.getData(
      action: "getOrderJualBonusDetail",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _orderjualbonusdetail = response.right.data.data;
      notify();
    }
  }

  Future<bool> deleteOrderJualModel({
    required int dihapusoleh,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setDeleteOrderJualDTOApi.setDeleteOrderJual(
      action: "softDeleteOrderJual",
      dihapusoleh: json.decode(userDataJson!)['nomor'],
      nomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
