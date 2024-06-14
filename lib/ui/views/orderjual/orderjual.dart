import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/delete_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/orderjual/orderjual_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/orderjual/detailorder.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editorderjual.dart';

import '../../shared/spacings.dart';
import '../../widgets/search_bar.dart' as search;

class OrderJualView extends ConsumerStatefulWidget {
  const OrderJualView({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderJualView> createState() => _OrderJualViewState();
}

class _OrderJualViewState extends ConsumerState<OrderJualView> {
  final TextEditingController _searchController = TextEditingController();

  // ignore: unused_element
  void _onSearchTextChanged(String query) {
    debugPrint("Teks pencarian: $query");
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<OrderJualViewModel>(
        model: OrderJualViewModel(
          orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
          setDeleteOrderJualDTOApi: ref.read(setDeleteOrderJualDTOApi),
          // nomor: ,
        ),
        onModelReady: (OrderJualViewModel model) => model.initModel(),
        builder: (_, OrderJualViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: MjkColor.white,
                  appBar: AppBar(
                    backgroundColor: MjkColor.backgroundAtas,
                    title: const Text(
                      'Daftar Order Jual',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      model.initModel();
                      setState(() {
                        model.searchQuery = '';
                        _searchController.text = '';
                        model.fetchOrderJual(reload: true);
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            children: [
                              search.SearchBar(
                                controller: _searchController,
                                hintText: 'Cari',
                                onFieldSubmitted: (value) {
                                  model.searchQuery = value;
                                  model.fetchOrderJual(reload: true);
                                },
                              ),
                              Spacings.verSpace(
                                24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 41,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(MjkColor.floatButtonSalesColor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.daftarorderjual,
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Katalog Produk',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacings.horSpace(15),
                                      const Icon(
                                        Icons.book_outlined,
                                        color: MjkColor.white,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacings.verSpace(24),
                            ],
                          ),
                        ),
                        Expanded(
                          child: LazyLoadScrollView(
                            isLoading: model.busy,
                            onEndOfPage: () => model.isLastPage == false ? model.fetchOrderJual() : null,
                            child: RefreshIndicator(
                              onRefresh: () async => model.initModel(),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) => Spacings.verSpace(12),
                                  itemCount: model.orderjual.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
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
                                                Routes.detailorderpenjualan,
                                                arguments: DetailOrderPenjualanParam(
                                                  nomor: model.orderjual[index].nomor,
                                                  mode: 'view',
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                width: 120,
                                                                height: 25,
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  color: MjkColor.lightBlue006,
                                                                ),
                                                                child: Text(
                                                                  model.orderjual[index].kode,
                                                                  textAlign: TextAlign.center,
                                                                  style: const TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacings.verSpace(5),
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
                                                                      text: 'Tanggal\n',
                                                                      style: TextStyle(
                                                                        fontSize: 15.376,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: MjkColor.lightBlack018,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: model.orderjual[index].tanggal != null
                                                                          ? DateFormat('dd MMMM yyyy').format(
                                                                              DateTime.tryParse(model
                                                                                      .orderjual[index].tanggal!) ??
                                                                                  DateTime.now(),
                                                                            )
                                                                          : '', // Jika tanggal null atau kosong, tampilkan string kosong
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
                                                          PopupMenuButton<String>(
                                                            iconColor: MjkColor.black,
                                                            itemBuilder: (BuildContext context) {
                                                              return [
                                                                PopupMenuItem<String>(
                                                                  value: 'edit',
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: const EdgeInsets.all(0),
                                                                      backgroundColor:
                                                                          Color(MjkColor.transparent.value),
                                                                      surfaceTintColor: MjkColor.transparent,
                                                                      shadowColor: MjkColor.transparent,
                                                                      shape: const RoundedRectangleBorder(
                                                                        side: BorderSide.none,
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.zero,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.pushNamed(
                                                                        context,
                                                                        Routes.editorderjual,
                                                                        arguments: EditOrderJualParam(
                                                                          nomor: model.orderjual[index].nomor,
                                                                          mode: 'edit',
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons.edit,
                                                                          color: MjkColor.black,
                                                                        ),
                                                                        Spacings.horSpace(10),
                                                                        const Text(
                                                                          'Edit',
                                                                          style: TextStyle(
                                                                            color: MjkColor.black,
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                PopupMenuItem<String>(
                                                                  value: 'delete',
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: const EdgeInsets.all(0),
                                                                      backgroundColor:
                                                                          Color(MjkColor.transparent.value),
                                                                      surfaceTintColor: MjkColor.transparent,
                                                                      shadowColor: MjkColor.transparent,
                                                                      shape: const RoundedRectangleBorder(
                                                                        side: BorderSide.none,
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.zero,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return AlertDialog(
                                                                            title: const Text('Hapus Data Order'),
                                                                            content: const Text(
                                                                                'Apakah anda yakin menghapus order ini?'),
                                                                            actions: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  TextButton(
                                                                                    child: const Text('Ya'),
                                                                                    onPressed: () async {
                                                                                      bool success = await model
                                                                                          .deleteOrderJualModel(
                                                                                        dihapusoleh: 1,
                                                                                        nomor: model
                                                                                            .orderjual[index].nomor,
                                                                                      );
                                                                                      // ignore: use_build_context_synchronously
                                                                                      Navigator.pop(context);
                                                                                      // Tutup dialog konfirmasi pertama
                                                                                      if (success) {
                                                                                        // Jika berhasil, tampilkan dialog berhasil
                                                                                        showDialog(
                                                                                          // ignore: use_build_context_synchronously
                                                                                          context: context,
                                                                                          builder:
                                                                                              (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title: const Text(
                                                                                                  'Berhasil'),
                                                                                              content: const Text(
                                                                                                  'Order berhasil dihapus.'),
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child:
                                                                                                      const Text('OK'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(
                                                                                                        context);
                                                                                                    model.initModel();
                                                                                                    setState(() {
                                                                                                      model
                                                                                                          .fetchOrderJual(
                                                                                                              reload:
                                                                                                                  true);
                                                                                                    });
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      } else {
                                                                                        // Jika gagal, tampilkan dialog gagal
                                                                                        showDialog(
                                                                                          // ignore: use_build_context_synchronously
                                                                                          context: context,
                                                                                          builder:
                                                                                              (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title:
                                                                                                  const Text('Gagal'),
                                                                                              content: const Text(
                                                                                                  'Gagal menghapus order.'),
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child:
                                                                                                      const Text('OK'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(
                                                                                                        context);
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    child: const Text('Tidak'),
                                                                                    onPressed: () {
                                                                                      Navigator.pop(
                                                                                          context); // Tutup dialog konfirmasi pertama
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons.delete,
                                                                          color: MjkColor.red,
                                                                        ),
                                                                        Spacings.horSpace(10),
                                                                        const Text(
                                                                          'Delete',
                                                                          style: TextStyle(
                                                                            color: MjkColor.black,
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ];
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacings.verSpace(12),
                                          const Divider(
                                            height: 1,
                                            color: MjkColor.lightBlack009,
                                          ),
                                          Spacings.verSpace(12),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Spacings.verSpace(14),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    key: const Key("customer_FAB"),
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.addorderjual,
                      );
                    },
                    backgroundColor: MjkColor.floatButtonSalesColor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 31.5,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
