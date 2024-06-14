import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mjk_apps/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:mjk_apps/core/networks/delete_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderJualViewModel extends BaseViewModel {
  OrderJualViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
    required SetDeleteOrderJualDTOService setDeleteOrderJualDTOApi,
  })  : _orderJualGetDataDTOApi = orderJualGetDataDTOApi,
        _setDeleteOrderJualDTOApi = setDeleteOrderJualDTOApi;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;
  final SetDeleteOrderJualDTOService _setDeleteOrderJualDTOApi;
  // final int _nomor;

  final List<OrderJualGetDataContent> _orderjual = [];
  List<OrderJualGetDataContent> get orderjual => _orderjual;
  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  String searchQuery = '';

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchOrderJual(reload: true);
    setBusy(false);
  }

  OrderJualGetFilter currentFilter = OrderJualGetFilter(
    limit: 10,
    page: 10,
    sort: 'DESC',
    orderby: 'thorderjual.nomor',
  );
  Future<void> fetchOrderJual({bool reload = false}) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'thorderjual.kode',
      query: searchQuery,
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

  Future<bool> deleteOrderJualModel({
    required int dihapusoleh,
    required int nomor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setDeleteOrderJualDTOApi.setDeleteOrderJual(
      action: "softDeleteOrderJual",
      dihapusoleh: json.decode(userDataJson!)['nomor'],
      nomor: nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
