import 'package:flutter/material.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/view_models/base_view_model.dart';

class CustomerViewModel extends BaseViewModel {
  CustomerViewModel({
    required GetDataDTOService getDataDTOApi,
  }) : _getDataDTOApi = getDataDTOApi;

  final GetDataDTOService _getDataDTOApi;

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

  String _currentSearchKey = 'mhrelasi.nama';
  String get currentSearchKey => _currentSearchKey;
  Future<void> fetchDaftarCustomer({bool reload = false, String? searchKey}) async {
    final search = GetSearch(
      term: 'like',
      key: searchKey ?? _currentSearchKey,
      query: searchQuery,
    );

    debugPrint('key: $searchKey, query: $searchQuery');

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

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void updateSearchKey(String newSearchKey) {
    _currentSearchKey = newSearchKey;
    fetchDaftarCustomer(reload: true, searchKey: _currentSearchKey);
  }
}
