import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/networks/barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/produk/itemdetail_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

import '../../shared/spacings.dart';

class DetailOrderJualParam {
  const DetailOrderJualParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailOrderJual extends ConsumerStatefulWidget {
  const DetailOrderJual({
    super.key,
    required this.param,
  });

  final DetailOrderJualParam param;

  @override
  ConsumerState<DetailOrderJual> createState() => _DetailOrderJualState();
}

class _DetailOrderJualState extends ConsumerState<DetailOrderJual> {
  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailOrderJualViewModel>(
        model: DetailOrderJualViewModel(
          barangGetDataDTOApi: ref.read(barangGetDataDTOApi),
          satuanBarangGetDataDTOApi: ref.read(satuanBarangGetDataDTOApi),
          sharedPreferencesService: ref.read(sharedPrefProvider),
          nomor: widget.param.nomor!,
        ),
        onModelReady: (DetailOrderJualViewModel model) => model.initModel(),
        builder: (_, DetailOrderJualViewModel model, __) {
          return UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: MjkColor.white,
                body: RefreshIndicator(
                  onRefresh: () async => model.initModel(),
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.reverse) {
                        setState(() {
                          tabIsHide = true;
                        });
                      } else if (notification.direction == ScrollDirection.forward) {
                        setState(() {
                          tabIsHide = false;
                        });
                      }

                      return true;
                    },
                    child: LoadingOverlay(
                      isLoading: model.busy,
                      child: CustomScrollView(
                        slivers: [
                          SliverStickyHeader.builder(
                            sticky: true,
                            builder: (context, state) {
                              return AnimatedSlide(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 200),
                                offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                child: Column(
                                  children: [
                                    AppBar(
                                      backgroundColor: MjkColor.backgroundAtas,
                                      title: Text(
                                        'Item Detail',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: tabIsHide == false ? 18 : 14,
                                        ),
                                      ),
                                      // centerTitle: true,
                                      toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, i) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          'https://indraco.com/gmb/tanpalogo/TUGUBUAYA/TB-301.png',
                                          width: MediaQuery.of(context).size.width,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                    Spacings.verSpace(
                                      20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.barang[0].nama,
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacings.verSpace(
                                                    5,
                                                  ),
                                                  Text(
                                                    model.barang[0].kode,
                                                    style: const TextStyle(
                                                      color: MjkColor.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacings.verSpace(
                                            20,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(color: Colors.grey, width: 1.0),
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                              ),
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
                                                          fontWeight: FontWeight.w400,
                                                          color: MjkColor.lightBlack008),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(12),
                                                const Divider(
                                                  height: 1,
                                                  color: MjkColor.lightBlack009,
                                                ),
                                                Spacings.verSpace(32),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Golongan',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].golonganbarang}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Jenis Penjualan',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].jenispenjualan}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Group',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].groupbarang}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Satuan',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].satuan1}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Berat',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].berat}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Konversi 2',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].konversisatuan2}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Konversi 3',
                                                      style: TextStyle(
                                                        color: Color(0xFF8F8F8F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${model.barang[0].konversisatuan3}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(
                                                  13,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: Color(0xFFEBEBEB),
                                                ),
                                                Spacings.verSpace(
                                                  30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                childCount: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
