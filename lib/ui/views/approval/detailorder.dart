// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/approval_order_jual_dto_network.dart';
import 'package:sru/core/networks/order_jual_get_data_dto_network.dart';
import 'package:sru/core/utilities/string_utils.dart';
import 'package:sru/core/view_models/approval/detailorder_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';

class ApprovalDetailOrderParam {
  const ApprovalDetailOrderParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class ApprovalDetailOrder extends ConsumerStatefulWidget {
  const ApprovalDetailOrder({
    super.key,
    required this.param,
  });

  final ApprovalDetailOrderParam param;

  @override
  ConsumerState<ApprovalDetailOrder> createState() => _ApprovalDetailOrderState();
}

class _ApprovalDetailOrderState extends ConsumerState<ApprovalDetailOrder> with TickerProviderStateMixin {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayalainController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController statusppnController = TextEditingController();
  final TextEditingController barangController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController satuanController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController qty1Controller = TextEditingController();
  final TextEditingController satuan1Controller = TextEditingController();
  final TextEditingController diskon1Controller = TextEditingController();
  final TextEditingController diskon2Controller = TextEditingController();
  final TextEditingController diskon3Controller = TextEditingController();
  final TextEditingController directController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  final TextEditingController barang1Controller = TextEditingController();
  final TextEditingController qtyunitController = TextEditingController();
  final TextEditingController satuanunitController = TextEditingController();
  final TextEditingController qtyisiController = TextEditingController();
  final TextEditingController satuanisiController = TextEditingController();
  final TextEditingController subtotal1Controller = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController umController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController total1Controller = TextEditingController();

  final TextEditingController stateController = TextEditingController();
  final FocusNode stateFocus = FocusNode();

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<ApprovalDetailOrderViewModel>(
      model: ApprovalDetailOrderViewModel(
        orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        setApprovalOrderJualDTOApi: ref.read(setApprovalOrderJualDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (ApprovalDetailOrderViewModel model) => model.initModel(),
      builder: (_, ApprovalDetailOrderViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: sruColor.white,
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
                    child: CustomScrollView(
                      slivers: [
                        SliverStickyHeader(
                          sticky: true,
                          header: Column(
                            children: [
                              Visibility(
                                visible: tabIsHide == false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Column(
                                  children: [
                                    AnimatedSlide(
                                      curve: Curves.easeIn,
                                      duration: const Duration(milliseconds: 200),
                                      offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                      child: Column(
                                        children: [
                                          AppBar(
                                            backgroundColor: sruColor.backgroundAtas,
                                            leading: IconButton(
                                              onPressed: () {
                                                Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Routes.navBarSales,
                                                  (route) => false,
                                                  arguments: NavbarSalesViewParam(
                                                    menuIndex: 4,
                                                    // 1 = Aktifitas Sales
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                              ),
                                            ),
                                            title: Text(
                                              'Detail Order',
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
                                    ),
                                  ],
                                ),
                              ),
                              if (model.statussetuju)
                                Container(
                                  color: sruColor.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: sruColor.red005,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Batal Setujui'),
                                                content: const Text('Apakah anda yakin batal menyetujui order ini?'),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        child: const Text('Ya'),
                                                        onPressed: () async {
                                                          final bool response = await model.approvalOrderJualModel(
                                                            statusdisetujui: 0,
                                                            disetujuioleh: 1,
                                                          );
                                                          Navigator.pop(context);
                                                          if (response) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Gagal'),
                                                                  content:
                                                                      const Text('Transaksi ini gagal di batal setuju'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Berhasil'),
                                                                  content:
                                                                      const Text('Transaksi telah di batal setujui'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pushNamedAndRemoveUntil(
                                                                          context,
                                                                          Routes.navBarSales,
                                                                          (route) => false,
                                                                          arguments: NavbarSalesViewParam(
                                                                            menuIndex: 4,
                                                                            // 1 = Aktifitas Sales
                                                                          ),
                                                                        );
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
                                                          Navigator.pop(context);
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
                                              Icons.close,
                                              color: sruColor.white,
                                              size: 20,
                                            ),
                                            Spacings.horSpace(8),
                                            const Column(
                                              children: [
                                                Text(
                                                  'Batal Setuju',
                                                  style: TextStyle(
                                                    color: sruColor.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (!model.statussetuju)
                                Container(
                                  color: sruColor.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: sruColor.green006,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Setuju'),
                                                content: const Text('Apakah anda yakin menyetujui order ini?'),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        child: const Text('Ya'),
                                                        onPressed: () async {
                                                          final bool response = await model.approvalOrderJualModel(
                                                            statusdisetujui: 1,
                                                            disetujuioleh: 1,
                                                          );
                                                          Navigator.pop(context);
                                                          if (response) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Gagal'),
                                                                  content: const Text('Transaksi gagal di setujui'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Berhasil'),
                                                                  content: const Text('Transaksi berhasil di setujui'),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pushNamedAndRemoveUntil(
                                                                          context,
                                                                          Routes.navBarSales,
                                                                          (route) => false,
                                                                          arguments: NavbarSalesViewParam(
                                                                            menuIndex: 4,
                                                                            // 1 = Aktifitas Sales
                                                                          ),
                                                                        );
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
                                                          Navigator.pop(context);
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
                                              Icons.check,
                                              color: sruColor.white,
                                              size: 20,
                                            ),
                                            Spacings.horSpace(8),
                                            const Text(
                                              'Setuju',
                                              style: TextStyle(
                                                color: sruColor.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 123,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: sruColor.red005,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Tolak'),
                                                  content: const Text('Apakah anda yakin menolak order ini?'),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          child: const Text('Ya'),
                                                          onPressed: () async {
                                                            final bool response = await model.approvalOrderJualModel(
                                                              statusdisetujui: 2,
                                                              disetujuioleh: 1,
                                                            );
                                                            Navigator.pop(context);
                                                            if (response) {
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Gagal'),
                                                                    content: const Text('Transaksi ini gagal di tolak'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        child: const Text('OK'),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Berhasil'),
                                                                    content: const Text('Transaksi telah di Tolak'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        child: const Text('OK'),
                                                                        onPressed: () {
                                                                          Navigator.pushNamedAndRemoveUntil(
                                                                            context,
                                                                            Routes.navBarSales,
                                                                            (route) => false,
                                                                            arguments: NavbarSalesViewParam(
                                                                              menuIndex: 4,
                                                                              // 1 = Aktifitas Sales
                                                                            ),
                                                                          );
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
                                                            Navigator.pop(context);
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
                                                Icons.close,
                                                color: sruColor.white,
                                                size: 20,
                                              ),
                                              Spacings.horSpace(8),
                                              const Text(
                                                'Tolak',
                                                style: TextStyle(
                                                  color: sruColor.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
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
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 24,
                                      right: 24,
                                      bottom: 4,
                                    ),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'Detail Barang',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kode',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: sruColor.lightBlack011,
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
                                              color: sruColor.black,
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
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: tanggalController,
                                          decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                              hintText: DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(model.orderjual[0].tanggal ?? ''),
                                              ),
                                              hintStyle: const TextStyle(
                                                color: sruColor.black,
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
                                              suffixIcon: const Icon(
                                                Icons.calendar_month,
                                                color: sruColor.lightBlack016,
                                                size: 16,
                                              )),
                                          readOnly: true,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Customer',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: customerController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].customer}',
                                            hintStyle: const TextStyle(
                                              color: sruColor.black,
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
                                              'Sales',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: salesController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].sales}',
                                            hintStyle: const TextStyle(
                                              color: sruColor.black,
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
                                              'Keterangan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            maxLines: null,
                                            minLines: 5,
                                            keyboardType: TextInputType.multiline,
                                            scrollPadding: const EdgeInsets.all(8.0),
                                            controller: keteranganController,
                                            decoration: InputDecoration(
                                              hintText: '${model.orderjual[0].keterangan}',
                                              hintStyle: const TextStyle(
                                                color: sruColor.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Status PPN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: sruColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: statusppnController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: StringUtils.rupiahFormat(
                                              double.parse(model.orderjual[0].statusppn != null
                                                  ? '${model.orderjual[0].statusppn}'
                                                  : '0'),
                                              symbol: 'Rp. ',
                                            ),
                                            hintStyle: const TextStyle(
                                              color: sruColor.black,
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
                                                color: sruColor.lightBlack008,
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
                                                                  color: sruColor.black,
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
                                                            color: sruColor.black,
                                                          ),
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Text(
                                                          '${model.orderjualdetail[index].qty} ${model.orderjualdetail[index].satuanqty}',
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w400,
                                                            color: sruColor.black,
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
                                                            color: sruColor.black,
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
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Visibility(
                                          visible: model.orderjualbonusdetail.isNotEmpty,
                                          child: Column(
                                            children: [
                                              Spacings.verSpace(14),
                                              const Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'DETAIL BONUS BARANG',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: sruColor.lightBlack008,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacings.verSpace(14),
                                              const Divider(
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: model.orderjualbonusdetail.isNotEmpty,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: model.orderjualbonusdetail.length,
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
                                                                  model.orderjualbonusdetail[index].kodebarang,
                                                                  style: const TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: sruColor.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacings.verSpace(5),
                                                          Text(
                                                            '${model.orderjualbonusdetail[index].barang}',
                                                            style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w400,
                                                              color: sruColor.black,
                                                            ),
                                                          ),
                                                          Spacings.verSpace(5),
                                                          Text(
                                                            '${model.orderjualbonusdetail[index].qtyunit} ${model.orderjualbonusdetail[index].satuanunit}',
                                                            style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w400,
                                                              color: sruColor.black,
                                                            ),
                                                          ),
                                                          Spacings.verSpace(5),
                                                          Text(
                                                            '${model.orderjualbonusdetail[index].qtyisi} ${model.orderjualbonusdetail[index].satuanisi}',
                                                            style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w400,
                                                              color: sruColor.black,
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 14,
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
                                                      color: sruColor.lightBlack011,
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
                                                                      color: sruColor.black,
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
                                                                    color: sruColor.black,
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
                                                      color: sruColor.lightBlack011,
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
                                                            color: sruColor.black,
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
                                                            color: sruColor.lightBlack011,
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
                                                                  color: sruColor.black,
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
                                                            color: sruColor.lightBlack011,
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
                                                                          color: sruColor.black,
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
                                                                          color: sruColor.black,
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
                                                      color: sruColor.lightBlack011,
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
                                                    color: sruColor.black,
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
                                                      color: sruColor.lightBlack011,
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
                                                            color: sruColor.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
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
                                        Spacings.verSpace(48),
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
}
