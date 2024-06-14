import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/pengiriman/daftarpengiriman_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/pengiriman/detail_barcode_view.dart';
import 'package:mjk_apps/ui/views/pengiriman/trackingpengiriman.dart';

import '../../shared/spacings.dart';

class DaftarPengirimanView extends ConsumerStatefulWidget {
  const DaftarPengirimanView({Key? key}) : super(key: key);

  @override
  ConsumerState<DaftarPengirimanView> createState() => _DaftarPengirimanViewState();
}

class _DaftarPengirimanViewState extends ConsumerState<DaftarPengirimanView> {
  String qrCodeResult = "Scan belum berhasil";

  @override
  Widget build(BuildContext context) {
    return ViewModel<DaftarPengirimanViewModel>(
        model: DaftarPengirimanViewModel(
          orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        ),
        onModelReady: (DaftarPengirimanViewModel model) => model.initModel(),
        builder: (_, DaftarPengirimanViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: MjkColor.white,
                  appBar: AppBar(
                    backgroundColor: MjkColor.backgroundAtas,
                    title: const Text(
                      'Daftar Pengiriman',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const ImageIcon(
                          AssetImage(
                            'assets/icons/ri_qr-scan-line.png',
                          ),
                          color: MjkColor.black,
                          size: 31,
                        ),
                        style: const ButtonStyle(),
                        onPressed: () async {
                          String qrCode = await FlutterBarcodeScanner.scanBarcode(
                            '#ff6666',
                            'Tutup',
                            true,
                            ScanMode.QR,
                          );

                          if (!mounted) return; // Hindari setState setelah widget di-dispose

                          setState(() {
                            qrCodeResult = qrCode;
                          });

                          if (qrCodeResult.startsWith('nomor : ')) {
                            try {
                              int nomor = int.parse(qrCodeResult.split(' : ')[1]);
                              Navigator.pushNamed(
                                // ignore: use_build_context_synchronously
                                context,
                                Routes.detailbarcode,
                                arguments: DetailBarcodeParam(
                                  nomor: nomor,
                                  mode: 'view',
                                ),
                              );
                            } catch (e) {
                              // Tangani kesalahan jika format barcode tidak sesuai
                              debugPrint('Format barcode tidak valid: $e');
                              // Tampilkan pesan error kepada pengguna (opsional)
                            }
                          }
                        },
                      ),
                    ],
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: LazyLoadScrollView(
                          isLoading: model.busy,
                          onEndOfPage: () => model.isLastPage == false ? model.fetchOrderJual() : null,
                          child: RefreshIndicator(
                            onRefresh: () async => model.initModel(),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.orderjual.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0),
                                            backgroundColor: Color(Colors.transparent.value),
                                            surfaceTintColor: Colors.white,
                                            shadowColor: const Color(0x00000000),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.trackingpengiriman,
                                              arguments: TrackingPengirimanParam(
                                                nomor: model.orderjual[index].nomor,
                                                mode: 'view',
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              const Divider(
                                                height: 1,
                                                color: MjkColor.lightBlack009,
                                              ),
                                              Spacings.verSpace(12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 56,
                                                    height: 56,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle, // Makes the container circular
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        'https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80', // Replace with your image URL
                                                        fit: BoxFit
                                                            .cover, // You can choose the BoxFit that suits your needs
                                                      ),
                                                    ),
                                                  ),
                                                  Spacings.horSpace(20),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${model.orderjual[index].customer}',
                                                                  style: const TextStyle(
                                                                    fontSize: 15.376,
                                                                    color: MjkColor.black,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacings.verSpace(5),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: 'Sales\n',
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: MjkColor.lightBlack018,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: '${model.orderjual[index].sales}',
                                                                        style: const TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: MjkColor.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Spacings.horSpace(50),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: 'Status\n',
                                                                        style: TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: MjkColor.lightBlack018,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: model.orderjual[0].statusdelivery,
                                                                        style: const TextStyle(
                                                                          fontSize: 15.376,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: MjkColor.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                  context,
                                                                  Routes.trackingpengiriman,
                                                                  arguments: TrackingPengirimanParam(
                                                                    nomor: model.orderjual[index].nomor,
                                                                    mode: 'view',
                                                                  ),
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.chevron_right,
                                                                size: 30,
                                                                color: MjkColor.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Spacings.verSpace(12),
                                              // const Divider(
                                              //   height: 1,
                                              //   color: MjkColor.lightBlack009,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
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
