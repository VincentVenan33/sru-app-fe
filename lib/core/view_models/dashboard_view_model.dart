import 'package:mjk_apps/core/models/get_data/dashboard_get_data_dto.dart';
import 'package:mjk_apps/core/networks/dashboard_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/authentication_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel({
    required AuthenticationService authenticationService,
    required DashboardGetDataDTOService dashboardGetDataDTOApi,
  })  : _authenticationService = authenticationService,
        _dashboardGetDataDTOApi = dashboardGetDataDTOApi;

  final AuthenticationService _authenticationService;
  final DashboardGetDataDTOService _dashboardGetDataDTOApi;

  DashboardGetDataContent? _omzet;
  DashboardGetDataContent? get omzet => _omzet;

  DashboardGetDataContent? _piutang;
  DashboardGetDataContent? get piutang => _piutang;

  List<DashboardGetDataContent> _orderjual = [];
  List<DashboardGetDataContent> get orderjual => _orderjual;

  // Add a method to handle login from shared preference
  // bool _isLoggedIn = false;
  // bool get isLoggedIn => _isLoggedIn;

  @override
  Future<void> initModel() async {
    setBusy(true);
    //await getLoggedInStatus();
    await _fetchOmzet();
    await _fetchPiutang();
    await _fetchOrderJual();
    setBusy(false);
  }

  Future<void> _fetchOmzet() async {
    final filters = DashboardGetFilter(
      limit: 1,
    );

    final response = await _dashboardGetDataDTOApi.getData(
      action: "getOmzet",
      filters: filters,
    );

    if (response.isRight) {
      _omzet = response.right.data.data[0];
      notify();
    }
  }

  Future<void> _fetchPiutang() async {
    final filters = DashboardGetFilter(
      limit: 1,
    );

    final response = await _dashboardGetDataDTOApi.getData(
      action: "getPiutang",
      filters: filters,
    );

    if (response.isRight) {
      _piutang = response.right.data.data[0];
      notify();
    }
  }

  Future<void> _fetchOrderJual() async {
    final filters = DashboardGetFilter(
      limit: 10,
      sort: "DESC",
      orderby: "thorderjual.nomor",
    );

    final response = await _dashboardGetDataDTOApi.getData(
      action: "getOrderJual",
      filters: filters,
    );

    if (response.isRight) {
      _orderjual = response.right.data.data;
      notify();
    }
  }

  Future<bool> requestLogout() async {
    // ignore: unused_local_variable
    final response = await _authenticationService.logout();

    return true;
  }
}
