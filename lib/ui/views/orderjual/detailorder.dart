import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/delete_order_jual_dto.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/utilities/string_utils.dart';
import 'package:mjk_apps/core/view_models/orderjual/detail_order_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';

class DetailOrderPenjualanParam {
  const DetailOrderPenjualanParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailOrderPenjualan extends ConsumerStatefulWidget {
  const DetailOrderPenjualan({
    super.key,
    required this.param,
  });
  final DetailOrderPenjualanParam param;
  @override
  ConsumerState<DetailOrderPenjualan> createState() => _DetailOrderPenjualanState();
}

class _DetailOrderPenjualanState extends ConsumerState<DetailOrderPenjualan> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayalainController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController satuanController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController satuan1Controller = TextEditingController();
  final TextEditingController pricelistController = TextEditingController();
  final TextEditingController penawaranController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  // ignore: unused_element
  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailOrderPenjualanViewModel>(
      model: DetailOrderPenjualanViewModel(
        orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        setDeleteOrderJualDTOApi: ref.read(setDeleteOrderJualDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (DetailOrderPenjualanViewModel model) => model.initModel(),
      builder: (_, DetailOrderPenjualanViewModel model, __) {
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
                        SliverStickyHeader(
                          sticky: true,
                          header: AnimatedSlide(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 200),
                            offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor: MjkColor.backgroundAtas,
                                  title: Text(
                                    'Detail Order Jual',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: tabIsHide == false ? 18 : 14,
                                    ),
                                  ),
                                  actions: [
                                    PopupMenuButton<String>(
                                      iconColor: MjkColor.black,
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            value: 'edit',
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.all(0),
                                                backgroundColor: Color(MjkColor.transparent.value),
                                                surfaceTintColor: MjkColor.transparent,
                                                shadowColor: MjkColor.transparent,
                                                shape: const RoundedRectangleBorder(
                                                  side: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.zero,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
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
                                                backgroundColor: Color(MjkColor.transparent.value),
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
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Hapus Data Order'),
                                                      content: const Text('Apakah anda yakin menghapus order ini?'),
                                                      actions: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            TextButton(
                                                              child: const Text('Ya'),
                                                              onPressed: () async {
                                                                bool success = await model.deleteOrderJualModel(
                                                                  dihapusoleh: 1,
                                                                );
                                                                // ignore: use_build_context_synchronously
                                                                Navigator.pop(context);
                                                                // Tutup dialog konfirmasi pertama
                                                                if (success) {
                                                                  // Jika berhasil, tampilkan dialog berhasil
                                                                  showDialog(
                                                                    // ignore: use_build_context_synchronously
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text('Berhasil'),
                                                                        content: const Text('Order berhasil dihapus.'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            child: const Text('OK'),
                                                                            onPressed: () {
                                                                              Navigator.pushNamedAndRemoveUntil(
                                                                                context,
                                                                                Routes.navBarSales,
                                                                                (route) => false,
                                                                                arguments: NavbarSalesViewParam(
                                                                                  menuIndex: 2,
                                                                                  // 1 = Aktifitas Sales
                                                                                ),
                                                                              );
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
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text('Gagal'),
                                                                        content: const Text('Gagal menghapus order.'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            child: const Text('OK'),
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context); // Tutup dialog gagal
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
                                  // centerTitle: true,
                                  toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                ),
                              ],
                            ),
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 19,
                                    ),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'Kode',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: kodeController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.orderjual[0].kode,
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
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
                                          readOnly: true,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Tanggal',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(
                                                8,
                                              ),
                                              side: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              backgroundColor: MjkColor.transparent,
                                              surfaceTintColor: Colors.white,
                                              shadowColor: const Color(0x00000000),
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${model.orderjual[0].tanggal}',
                                                  style: const TextStyle(
                                                    color: MjkColor.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: MjkColor.lightBlack016,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Customer',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: customerController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].customer}',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Sales',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: salesController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].sales}',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'PPN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: ppnController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.orderjual[0].statusppn != null
                                                ? _getStatusPPNText(model.orderjual[0].statusppn!)
                                                : '-',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'DETAIL BARANG',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: MjkColor.lightBlack008,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: model.orderjualdetail.length,
                                          separatorBuilder: (context, index) => const Divider(),
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.network(
                                                        'https://indraco.com/gmb/tanpalogo/TUGUBUAYA/TB-301.png',
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                model.orderjualdetail[index].kodebarang,
                                                                style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: MjkColor.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Text(
                                                          '${model.orderjualdetail[index].barang}',
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w400,
                                                            color: MjkColor.black,
                                                          ),
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Text(
                                                          '${model.orderjualdetail[index].qty} ${model.orderjualdetail[index].satuanqty}',
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w400,
                                                            color: MjkColor.black,
                                                          ),
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Text(
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjualdetail[index].subtotal != null
                                                                ? '${model.orderjualdetail[index].subtotal}'
                                                                : '0'),
                                                            symbol: 'Subtotal (Rp) : ',
                                                          ),
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w400,
                                                            color: MjkColor.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 19,
                                          ),
                                          child: Column(
                                            children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Discount',
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
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: 207,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                TextFormField(
                                                                  controller: diskonprosentaseController,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      // hitung();
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    contentPadding: const EdgeInsets.only(
                                                                      left: 16,
                                                                      top: 6,
                                                                      bottom: 6,
                                                                    ),
                                                                    hintText:
                                                                        '${model.orderjual[0].diskonprosentase}.00',
                                                                    hintStyle: const TextStyle(
                                                                      color: MjkColor.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14,
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors.grey, width: 1.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors.blue, width: 1.0),
                                                                    ),
                                                                  ),
                                                                  keyboardType: TextInputType.number,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.allow(
                                                                      RegExp(r'[0-9]'),
                                                                    ),
                                                                  ],
                                                                  readOnly: true,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Spacings.horSpace(10),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 48,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  StringUtils.rupiahFormat(
                                                                    // ignore: unnecessary_null_comparison
                                                                    double.parse(
                                                                        model.orderjual[0].diskonnominal != null
                                                                            ? '${model.orderjual[0].diskonnominal}'
                                                                            : '0'),
                                                                    symbol: '',
                                                                  ),
                                                                  style: const TextStyle(
                                                                    color: MjkColor.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacings.verSpace(14),
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
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjual[0].subtotal2 != null
                                                                ? '${model.orderjual[0].subtotal2}'
                                                                : '0'),
                                                            symbol: '',
                                                          ),
                                                          style: const TextStyle(
                                                            color: MjkColor.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacings.verSpace(14),
                                              Visibility(
                                                visible: model.orderjual[0].statusppn == 1,
                                                child: Column(
                                                  children: [
                                                    const Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'DPP',
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
                                                                StringUtils.rupiahFormat(
                                                                  // ignore: unnecessary_null_comparison
                                                                  double.parse(model.orderjual[0].dpp != null
                                                                      ? '${model.orderjual[0].dpp}'
                                                                      : '0'),
                                                                  symbol: '',
                                                                ),
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
                                                    Spacings.verSpace(14),
                                                    const Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'PPN',
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
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: SizedBox(
                                                                  height: 48,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '${model.orderjual[0].ppnprosentase}.00',
                                                                        style: const TextStyle(
                                                                          color: MjkColor.black,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 17,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacings.horSpace(10),
                                                              Expanded(
                                                                child: SizedBox(
                                                                  height: 48,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Text(
                                                                        StringUtils.rupiahFormat(
                                                                          // ignore: unnecessary_null_comparison
                                                                          double.parse(
                                                                              model.orderjual[0].ppnnominal != null
                                                                                  ? '${model.orderjual[0].ppnnominal}'
                                                                                  : '0'),
                                                                          symbol: '',
                                                                        ),
                                                                        style: const TextStyle(
                                                                          color: MjkColor.black,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 17,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
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
                                              Spacings.verSpace(14),
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Biaya Lain',
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
                                                controller: biayalainController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // hitung2();
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                  hintText: StringUtils.rupiahFormat(
                                                    // ignore: unnecessary_null_comparison
                                                    double.parse(model.orderjual[0].totalbiaya != null
                                                        ? '${model.orderjual[0].totalbiaya}'
                                                        : '0'),
                                                    symbol: '',
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    color: MjkColor.black,
                                                    fontWeight: FontWeight.w500,
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
                                              Spacings.verSpace(14),
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Total',
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
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjual[0].total != null
                                                                ? '${model.orderjual[0].total}'
                                                                : '0'),
                                                            symbol: '',
                                                          ),
                                                          style: const TextStyle(
                                                            color: MjkColor.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacings.verSpace(14),
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
      },
    );
  }

  String _getStatusPPNText(int statusppn) {
    switch (statusppn) {
      case 0:
        return 'Non-PPN';
      case 1:
        return 'PPN';
      default:
        return '-';
    }
  }
}
