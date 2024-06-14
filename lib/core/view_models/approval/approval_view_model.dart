import 'package:flutter/material.dart';
import 'package:sru/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:sru/core/networks/order_jual_get_data_dto_network.dart';
import 'package:sru/core/view_models/base_view_model.dart';

class ApprovalViewModel extends BaseViewModel {
  ApprovalViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
  }) : _orderJualGetDataDTOApi = orderJualGetDataDTOApi;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;

  final List<OrderJualGetDataContent> _orderjual = [];
  List<OrderJualGetDataContent> get orderjual => _orderjual;
  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

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
}
