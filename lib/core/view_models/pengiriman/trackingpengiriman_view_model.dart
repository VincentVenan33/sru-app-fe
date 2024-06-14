import 'package:sru/core/models/get_data/tracking_order_jual_get_data_dto.dart';
import 'package:sru/core/networks/tracking_order_jual_get_data_dto_network.dart';
import 'package:sru/core/view_models/base_view_model.dart';

class TrackingPengirimanViewModel extends BaseViewModel {
  TrackingPengirimanViewModel({
    required TrackingOrderJualGetDataDTOService trackingOrderJualGetDataDTOApi,
    required int nomor,
  })  : _trackingOrderJualGetDataDTOApi = trackingOrderJualGetDataDTOApi,
        _nomor = nomor;

  final TrackingOrderJualGetDataDTOService _trackingOrderJualGetDataDTOApi;
  final int _nomor;

  List<TrackingOrderJualGetDataContent> _trackingorderjual = [];
  List<TrackingOrderJualGetDataContent> get trackingorderjual => _trackingorderjual;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchOrderJual();
    setBusy(false);
  }

  // ignore: unused_element
  Future<void> _fetchOrderJual({bool reload = false}) async {
    final filters = TrackingOrderJualGetFilter(
      nomor: _nomor,
    );

    final response = await _trackingOrderJualGetDataDTOApi.getData(
      action: "getTrackingOrderJual",
      filters: filters,
    );

    if (response.isRight) {
      _trackingorderjual = response.right.data.data;
      notify();
    }
  }
}
