import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/tracking_order_jual_get_data_dto_network.dart';
import 'package:sru/core/view_models/pengiriman/trackingpengiriman_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';

class TrackingPengirimanParam {
  const TrackingPengirimanParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class TrackingPengiriman extends ConsumerStatefulWidget {
  const TrackingPengiriman({
    super.key,
    required this.param,
  });
  final TrackingPengirimanParam param;
  @override
  ConsumerState<TrackingPengiriman> createState() => _TrackingPengirimanState();
}

class _TrackingPengirimanState extends ConsumerState<TrackingPengiriman> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<TrackingPengirimanViewModel>(
        model: TrackingPengirimanViewModel(
          trackingOrderJualGetDataDTOApi: ref.read(trackingOrderJualGetDataDTOApi),
          nomor: widget.param.nomor!,
        ),
        onModelReady: (TrackingPengirimanViewModel model) => model.initModel(),
        builder: (_, TrackingPengirimanViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: sruColor.white,
                  appBar: AppBar(
                    backgroundColor: sruColor.backgroundAtas,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.navBarSales,
                          (route) => false,
                          arguments: NavbarSalesViewParam(
                            menuIndex: 3,
                            // 1 = Aktifitas Sales
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    title: const Text(
                      'Tracking Pengiriman',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: const CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                            ),
                            DraggableScrollableSheet(
                              initialChildSize: 0.6,
                              minChildSize: 0.1,
                              maxChildSize: 0.6,
                              builder: (BuildContext context, ScrollController scrollController) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                          title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Column(
                                          children: [
                                            const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Detail Produk',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: sruColor.lightBlack008,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: sruColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(5),
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 42,
                                                          height: 42,
                                                          decoration: BoxDecoration(
                                                            color: model.trackingorderjual[0].statusoj == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(7)),
                                                          ),
                                                          child: const Icon(
                                                            Icons.location_on,
                                                            color: sruColor.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 47,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            color: model.trackingorderjual[0].statusdo == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          height: 18,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: model.trackingorderjual[0].statusdo == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 53,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            color: model.trackingorderjual[0].statussj == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          height: 18,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: model.trackingorderjual[0].statussj == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            color: model.trackingorderjual[0].statusberangkat == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          height: 18,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: model.trackingorderjual[0].statusberangkat == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 51,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            color: model.trackingorderjual[0].statussampai == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          height: 18,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: model.trackingorderjual[0].statussampai == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 47,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            color: model.trackingorderjual[0].statusdatang == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 42,
                                                          height: 42,
                                                          decoration: BoxDecoration(
                                                            color: model.trackingorderjual[0].statusdatang == 1
                                                                ? sruColor.floatButtonSalesColor
                                                                : sruColor.navbarUnselectedColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(7)),
                                                          ),
                                                          child: const Icon(
                                                            Icons.check,
                                                            color: sruColor.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Spacings.horSpace(18),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(24),
                                                    child: Column(
                                                      children: [
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Order Diterima',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.trackingorderjual[0].statusoj == 1
                                                                  ? 'Order sudah diterima oleh sistem'
                                                                  : 'Order belum diterima oleh sistem',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 12,
                                                                color: sruColor.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(47),
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Persiapan Barang',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.trackingorderjual[0].statusdo == 1
                                                                  ? 'Barang sedang disiapkan untuk dikirim'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 10,
                                                                color: sruColor.lightBlack018,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(33),
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Barang Siap Dikirim',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.trackingorderjual[0].statussj == 1
                                                                  ? 'Barang sudah siap untuk dikirim ke lokasi tujuan'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 10,
                                                                color: sruColor.lightBlack018,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(30),
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Barang Dikirim',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.trackingorderjual[0].statusberangkat == 1
                                                                  ? 'Barang sedang disiapkan untuk dikirim'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 10,
                                                                color: sruColor.lightBlack018,
                                                              ),
                                                            ),
                                                            Spacings.horSpace(4),
                                                            Text(
                                                              model.trackingorderjual[0].statusberangkat == 1
                                                                  ? '8-10hari'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10,
                                                                color: sruColor.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(30),
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Barang Sampai di Tujuan',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                model.trackingorderjual[0].statussampai == 1
                                                                    ? 'Barang anda sudah sampai di lokasi tujuan ${model.trackingorderjual[0].alamat}'
                                                                    : '',
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.w300,
                                                                  fontSize: 10,
                                                                  color: sruColor.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(6),
                                                        const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Pengiriman Selesai',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              model.trackingorderjual[0].statusdatang == 1
                                                                  ? 'Barang sudah resmi diterima oleh'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                                fontSize: 10,
                                                                color: sruColor.lightBlack018,
                                                              ),
                                                            ),
                                                            Spacings.horSpace(4),
                                                            Text(
                                                              model.trackingorderjual[0].statusdatang == 1
                                                                  ? '${model.trackingorderjual[0].nama}'
                                                                  : '',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10,
                                                                color: sruColor.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(27),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
