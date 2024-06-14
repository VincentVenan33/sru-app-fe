import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:mjk_apps/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:mjk_apps/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/produk/edititemdetail_view_model.dart';
import 'package:mjk_apps/core/view_models/produk/itemdetail_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

import '../../shared/spacings.dart';

class EditDetailOrderParam {
  const EditDetailOrderParam({
    this.nomor,
    this.mode,
    this.detailItem,
  });

  final int? nomor;
  final String? mode;
  final CreateOrderJualDetailRequest? detailItem;
}

class EditDetailOrderJual extends ConsumerStatefulWidget {
  const EditDetailOrderJual({
    super.key,
    required this.param,
  });

  final EditDetailOrderParam param;

  @override
  ConsumerState<EditDetailOrderJual> createState() => _EditDetailOrderJualState();
}

class _EditDetailOrderJualState extends ConsumerState<EditDetailOrderJual> {
  int _qty = 0;
  int _netto = 0;
  int _disctotal = 0;
  int _discdirect = 0;
  int _disc3 = 0;
  int _diskon3 = 0;
  int _disc2 = 0;
  int _diskon2 = 0;
  int _disc1 = 0;
  int _diskon1 = 0;
  int _isi = 0;
  int _harga = 0;
  int _subtotal = 0;
  int _konversisatuan = 0;
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController nomorbarangController = TextEditingController();
  final TextEditingController nomorsatuanController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController satuanqtyController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController satuanisiController = TextEditingController();
  final TextEditingController konversiSatuanController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController diskon1Controller = TextEditingController();
  final TextEditingController diskon2Controller = TextEditingController();
  final TextEditingController diskon3Controller = TextEditingController();
  final TextEditingController directController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  int jumlah = 0;
  double scrollPosition = 0.0;
  bool tabIsHide = false;

  late DetailOrderJualViewModel model;
  late int konversisatuan;

  @override
  void initState() {
    super.initState();
    kodeController.text = widget.param.detailItem?.kode.toString() ?? '';
    nomorbarangController.text = widget.param.detailItem?.nomormhbarang.toString() ?? '';
    nomorsatuanController.text = widget.param.detailItem?.nomormhsatuan.toString() ?? '';
    namaController.text = widget.param.detailItem?.nama.toString() ?? '';
    konversiSatuanController.text = widget.param.detailItem?.konversisatuan.toString() ?? '';
    hargaController.text = widget.param.detailItem?.harga.toString() ?? '';
    qtyController.text = widget.param.detailItem?.qty.toString() ?? '';
    satuanisiController.text = widget.param.detailItem?.satuanisi.toString() ?? '';
    isiController.text = widget.param.detailItem?.isi.toString() ?? '';
    diskon1Controller.text = widget.param.detailItem?.disc1.toString() ?? '';
    diskon2Controller.text = widget.param.detailItem?.disc2.toString() ?? '';
    diskon3Controller.text = widget.param.detailItem?.disc3.toString() ?? '';
    directController.text = widget.param.detailItem?.discdirect.toString() ?? '';
    totalController.text = widget.param.detailItem?.disctotal.toString() ?? '';
    nettoController.text = widget.param.detailItem?.netto.toString() ?? '';
    subtotalController.text = widget.param.detailItem?.subtotal.toString() ?? '';
    hargaController.addListener(calculateDiscTotal);
    diskon1Controller.addListener(calculateDiscTotal);
    diskon2Controller.addListener(calculateDiscTotal);
    diskon3Controller.addListener(calculateDiscTotal);
    directController.addListener(calculateDiscTotal);
    hargaController.addListener(calculateNetto);
    totalController.addListener(calculateNetto);
    qtyController.addListener(calculateSubtotal);
    nettoController.addListener(calculateSubtotal);
  }

  void calculateDiscTotal() {
    setState(() {
      _harga = int.tryParse(hargaController.text) ?? 0;
      double disc1Percentage = (double.tryParse(diskon1Controller.text) ?? 0) / 100;
      double disc2Percentage = (double.tryParse(diskon2Controller.text) ?? 0) / 100;
      double disc3Percentage = (double.tryParse(diskon3Controller.text) ?? 0) / 100;

      // Calculate discounts
      _diskon1 = (_harga * disc1Percentage).toInt();
      _diskon2 = ((_harga - _diskon1) * disc2Percentage).toInt();
      _diskon3 = ((_harga - _diskon1 - _diskon2) * disc3Percentage).toInt();

      _discdirect = int.tryParse(directController.text) ?? 0;
      debugPrint('diskon1 $_diskon1');
      debugPrint('diskon2 $_diskon2');
      debugPrint('diskon3 $_diskon3');
      // Calculate total
      _disctotal = _diskon1 + _diskon2 + _diskon3 + _discdirect;
      totalController.text = _disctotal.toString();
    });
  }

  void calculateNetto() {
    setState(() {
      _harga = int.tryParse(hargaController.text) ?? 0;
      _disctotal = int.tryParse(totalController.text) ?? 0;
      _netto = _harga - _disctotal;
      nettoController.text = _netto.toString();
    });
  }

  void calculateSubtotal() {
    setState(() {
      _qty = int.tryParse(qtyController.text) ?? 0;
      _netto = int.tryParse(nettoController.text) ?? 0;
      _subtotal = _qty * _netto;
      subtotalController.text = _subtotal.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<EditDetailOrderJualViewModel>(
      model: EditDetailOrderJualViewModel(
          satuanBarangGetDataDTOApi: ref.read(satuanBarangGetDataDTOApi),
          sharedPreferencesService: ref.read(sharedPrefProvider),
          detailitem: widget.param.detailItem,
          nomor: widget.param.nomor!,
          index: widget.param.nomor!),
      onModelReady: (EditDetailOrderJualViewModel model) => model.initModel(),
      builder: (_, EditDetailOrderJualViewModel model, __) {
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
                                    // actions: [
                                    //   IconButton(
                                    //     icon: const Icon(Icons.more_vert),
                                    //     onPressed: () {},
                                    //   ),
                                    // ],
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
                                                  kodeController.text,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Spacings.verSpace(
                                                  5,
                                                ),
                                                Text(
                                                  namaController.text,
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
                                        Column(
                                          children: [
                                            const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'QTY',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: MjkColor.lightBlack008),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: MjkColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Satuan',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: MjkColor.lightBlack011,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: DropdownButtonFormField<SatuanBarangGetDataContent>(
                                                    value: model.selectedSatuanBarang,
                                                    hint: Text(
                                                      '${widget.param.detailItem?.satuanqty}',
                                                      style: const TextStyle(
                                                          color: MjkColor.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    items: model.satuanbarang
                                                        .where((item) => item.nama != null)
                                                        .map((item) => DropdownMenuItem<SatuanBarangGetDataContent>(
                                                              value: item,
                                                              child: satuanBarang(
                                                                context,
                                                                item,
                                                              ),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          model.setselectedsatuanBarang(value);
                                                          _konversisatuan = value!.konversi!;
                                                          konversiSatuanController.text = _konversisatuan.toString();
                                                          _qty = int.tryParse(qtyController.text) ?? 0;
                                                          _konversisatuan =
                                                              int.tryParse(konversiSatuanController.text) ?? 0;
                                                          debugPrint('konversi satuan $_konversisatuan');
                                                          _isi = _qty * _konversisatuan;
                                                          _harga = value.hargapricelist!;
                                                          hargaController.text = _harga.toString();
                                                          isiController.text = _isi.toString();
                                                        },
                                                      );
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      model.setselectedsatuanBarang(null);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.refresh_outlined,
                                                    color: MjkColor.lightBlack014,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(
                                              10,
                                            ),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Jumlah',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: MjkColor.lightBlack011,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(5),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        MjkColor.floatButtonSalesColor, // Ubah ke warna yang sesuai
                                                    shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                          8,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _qty = int.tryParse(qtyController.text) ?? 0;
                                                      _konversisatuan =
                                                          int.tryParse(konversiSatuanController.text) ?? 0;
                                                      debugPrint('konversi satuan $_konversisatuan');
                                                      if (_qty > 0) {
                                                        _qty--;
                                                        qtyController.text = _qty.toString();
                                                        _isi = _qty * _konversisatuan;
                                                        isiController.text = _isi.toString();
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white, // Ubah ke warna yang sesuai
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller: qtyController,
                                                    textAlign: TextAlign.center,
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          _qty = int.tryParse(qtyController.text) ?? 0;
                                                          _konversisatuan =
                                                              int.tryParse(konversiSatuanController.text) ?? 0;
                                                          debugPrint('konversi satuan $_konversisatuan');
                                                          _isi = _qty * _konversisatuan;
                                                          isiController.text = _isi.toString();

                                                          _qty = int.tryParse(value) ?? 0;
                                                        },
                                                      );
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 8.5,
                                                      ),
                                                      hintText: 'Qty...',
                                                      hintStyle: const TextStyle(
                                                        color: Colors.black, // Ubah ke warna yang sesuai
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                                      ),
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                        RegExp(r'[0-9]'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                IconButton(
                                                  style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        MjkColor.floatButtonSalesColor, // Ubah ke warna yang sesuai
                                                    shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                          8,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _qty = int.tryParse(qtyController.text) ?? 0;
                                                      _konversisatuan =
                                                          int.tryParse(konversiSatuanController.text) ?? 0;
                                                      debugPrint('konversi satuan $_konversisatuan');
                                                      _qty++; // Menambah jumlah
                                                      qtyController.text = _qty.toString();
                                                      _isi = _qty * _konversisatuan;

                                                      isiController.text = _isi.toString();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.white, // Ubah ke warna yang sesuai
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(
                                              20,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Harga',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: MjkColor.lightBlack008),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacings.verSpace(12),
                                                  const Divider(
                                                    height: 1,
                                                    color: MjkColor.lightBlack009,
                                                  ),
                                                  Spacings.verSpace(37),
                                                  TextFormField(
                                                    controller: hargaController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _harga = int.tryParse(value) ?? 0;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                      hintText: 'Masukkan harga',
                                                      hintStyle: const TextStyle(
                                                        color: MjkColor.lightBlack015,
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14,
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                                      ),
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                        RegExp(r'[0-9]'),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacings.verSpace(
                                                    20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacings.horSpace(10),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'ISI',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: MjkColor.lightBlack008),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacings.verSpace(12),
                                                  const Divider(
                                                    height: 1,
                                                    color: MjkColor.lightBlack009,
                                                  ),
                                                  Spacings.verSpace(12),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            const Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Satuan',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: MjkColor.lightBlack011,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacings.verSpace(5),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 48,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        satuanisiController.text,
                                                                        style: const TextStyle(
                                                                          color: MjkColor.black,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 17,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacings.horSpace(
                                                        10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            const Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'Jumlah',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: MjkColor.lightBlack011,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacings.verSpace(5),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 48,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        isiController.text,
                                                                        style: const TextStyle(
                                                                          color: MjkColor.black,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 17,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacings.verSpace(
                                                    20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Discount (%)',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: MjkColor.lightBlack008),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: MjkColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '1',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: diskon1Controller,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _disc1 = int.tryParse(value) ?? 0;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon 1',
                                                          hintStyle: const TextStyle(
                                                            color: MjkColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '2',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: diskon2Controller,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _disc2 = int.tryParse(value) ?? 0;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon 2',
                                                          hintStyle: const TextStyle(
                                                            color: MjkColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '3',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: diskon3Controller,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _disc3 = int.tryParse(value) ?? 0;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon 3',
                                                          hintStyle: const TextStyle(
                                                            color: MjkColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(
                                              20,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Discount (Rp)',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: MjkColor.lightBlack008),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: MjkColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Direct',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: directController,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _discdirect = int.tryParse(value) ?? 0;
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon direct',
                                                          hintStyle: const TextStyle(
                                                            color: MjkColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Total Discount',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            height: 48,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  totalController.text,
                                                                  style: const TextStyle(
                                                                    color: MjkColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(
                                              20,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Summary',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: MjkColor.lightBlack008),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: MjkColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Netto',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            height: 48,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  nettoController.text,
                                                                  style: const TextStyle(
                                                                    color: MjkColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Subtotal',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: MjkColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            height: 48,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  subtotalController.text,
                                                                  style: const TextStyle(
                                                                    color: MjkColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(108),
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
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  bottom: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final bool response = await model.addItemtoList(
                            widget.param.nomor ?? 0,
                            CreateOrderJualDetailRequest(
                              nomormhbarang: int.parse(nomorbarangController.text),
                              nomormhsatuan: model.selectedSatuanBarang?.nomor ?? 0,
                              kode: widget.param.detailItem?.kode,
                              nama: widget.param.detailItem?.nama,
                              qty: _qty,
                              netto: int.parse(nettoController.text),
                              disctotal: int.parse(totalController.text),
                              discdirect: _discdirect,
                              disc3: _disc3,
                              disc2: _disc2,
                              disc1: _disc1,
                              satuanqty: model.selectedSatuanBarang?.nama ?? '',
                              isi: int.parse(isiController.text),
                              satuanisi: widget.param.detailItem?.satuanisi,
                              harga: _harga,
                              subtotal: int.parse(subtotalController.text),
                              konversisatuan: _konversisatuan,
                            ),
                          );

                          if (response) {
                            Navigator.pushNamed(
                              // ignore: use_build_context_synchronously
                              context,
                              Routes.addorderjual,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 124,
                            vertical: 16,
                          ),
                          backgroundColor: MjkColor.floatButtonSalesColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add Detail Barang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget satuanBarang(BuildContext context, SatuanBarangGetDataContent item) {
    return Text(
      '${item.nama}',
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }
}
