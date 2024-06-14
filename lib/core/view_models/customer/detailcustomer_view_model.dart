import 'package:flutter/material.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class DetailCustomerViewModel extends BaseViewModel {
  DetailCustomerViewModel({
    required GetDataDTOService getDataDTOApi,
    required int nomor,
  })  : _getDataDTOApi = getDataDTOApi,
        _nomor = nomor;

  final GetDataDTOService _getDataDTOApi;
  final int _nomor;

  final List<GetDataContent> _daftarcustomer = [];
  List<GetDataContent> get daftarcustomer => _daftarcustomer;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  String searchQuery = '';

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchDaftarCustomer(reload: true);
    setBusy(false);
  }

  GetFilter currentFilter = GetFilter(
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
        limit: currentFilter.limit,
        page: _currentPage,
        sort: currentFilter.sort,
        orderby: currentFilter.orderby,
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

        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
