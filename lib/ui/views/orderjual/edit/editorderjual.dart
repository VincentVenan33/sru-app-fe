import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/networks/delete_order_jual_detail_dto.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/order_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/update_order_jual_only_dto.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/utilities/string_utils.dart';
import 'package:mjk_apps/core/view_models/orderjual/edit/updateorderjual_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/edititemdetail.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editprodukkatalog.dart';

class EditOrderJualParam {
  const EditOrderJualParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class EditOrderJual extends ConsumerStatefulWidget {
  const EditOrderJual({
    super.key,
    required this.param,
  });

  final EditOrderJualParam param;

  @override
  ConsumerState<EditOrderJual> createState() => _EditOrderJualState();
}

class _EditOrderJualState extends ConsumerState<EditOrderJual> {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController(text: '0');
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayalainController = TextEditingController(text: '0');
  final TextEditingController totalController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController satuanqtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController satuanisiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  int _subtotal = 0;
  int _diskonnominal = 0;
  int _dpp = 0;
  int _ppn = 0;
  int _biayalain = 0;
  int _total = 0;

  @override
  void initState() {
    super.initState();
  }

  // void hitung() {
  //   setState(() {
  //     double disc1Percentage = (double.tryParse(diskonprosentaseController.text) ?? 0) / 100;

  //     _subtotal = int.parse(subtotalController.text);
  //     debugPrint('totalSubtotal $_subtotal');

  //     _diskonnominal = (_subtotal * disc1Percentage).toInt();
  //     diskonnominalController.text = _diskonnominal.toString();
  //     if (selectedPPN == '0') {
  //       _ppn = 0;
  //     } else {
  //       _ppn = (_dpp * 0.11).toInt();
  //     }
  //     _dpp = _subtotal - _diskonnominal.toInt();
  //     dppController.text = _dpp.toString();
  //     ppnnominalController.text = _ppn.toString();
  //     debugPrint('dpp : $_dpp');
  //     debugPrint('ppn : $_ppn');
  //     _biayalain = 0;
  //     debugPrint('biayalain : $_biayalain');
  //     _total = _dpp + _ppn + _biayalain;
  //     totalController.text = _total.toString();
  //   });
  // }

  // void hitung2() {
  //   setState(() {
  //     _dpp = int.parse(dppController.text);
  //     debugPrint('dpp : $_dpp');
  //     _ppn = int.parse(ppnnominalController.text);
  //     debugPrint('ppn : $_ppn');
  //     _biayalain = int.parse(biayalainController.text);
  //     _total = _dpp + _ppn + _biayalain;
  //     totalController.text = _total.toString();
  //   });
  // }

  // void _pickDate() async {
  //   DateTime? date = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime(2025),
  //   );

  //   if (date != null) {
  //     setState(() {
  //       _selectedDate = date;
  //     });
  //     debugPrint('tanggal $_selectedDate');
  //   }
  // }

  String? selectedPPN = '0';

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<UpdateOrderJualViewModel>(
      model: UpdateOrderJualViewModel(
        orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        getDataDTOApi: ref.read(getDataDTOApi),
        sharedPreferencesService: ref.read(sharedPrefProvider),
        setUpdateOrderJualOnlyDTOApi: ref.read(setUpdateOrderJualOnlyDTOApi),
        setDeleteOrderJualDetailDTOApi: ref.read(setDeleteOrderJualDetailDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (UpdateOrderJualViewModel model) => model.initModel(),
      builder: (_, UpdateOrderJualViewModel model, __) {
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
                          header: Column(
                            children: [
                              Column(
                                children: [
                                  AnimatedSlide(
                                    curve: Curves.easeIn,
                                    duration: const Duration(milliseconds: 200),
                                    offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                    child: Column(
                                      children: [
                                        AppBar(
                                          backgroundColor: MjkColor.backgroundAtas,
                                          leading: IconButton(
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
                                            icon: const Icon(
                                              Icons.arrow_back,
                                            ),
                                          ),
                                          title: Text(
                                            'Edit Order Jual',
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
                            ],
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
                                              'Kode*',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.horSpace(5),
                                        TextFormField(
                                          controller: model.kodeController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.kodeController.text,
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
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
                                          width: double.infinity,
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
                                              surfaceTintColor: MjkColor.transparent,
                                              shadowColor: const Color(0x00000000),
                                            ),
                                            onPressed: () async {
                                              final DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: model.selectedDate, // Default to today if not selected
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101),
                                              );

                                              if (picked != null && picked != model.selectedDate) {
                                                setState(() {
                                                  model.selectedDate = picked;
                                                });
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DateFormat('dd/MM/yyyy').format(model.selectedDate),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: MjkColor.black,
                                                    fontWeight: FontWeight.w400,
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
                                              'Pelanggan*',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.editpelangganorderjual,
                                              arguments: model,
                                            ).then((withResponse) {
                                              if (withResponse == false) {
                                                return;
                                              }
                                              if (model.selectedCustomer != null) {
                                                GetDataContent value = model.selectedCustomer!;
                                                setState(() {
                                                  model.customerController.text = value.nama;
                                                });
                                              }
                                            });
                                          },
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
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                model.customerController.text,
                                                style: const TextStyle(
                                                  color: MjkColor.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        model.customerController.clear();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.refresh,
                                                      color: MjkColor.lightBlack014,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.search,
                                                    color: MjkColor.lightBlack014,
                                                  ),
                                                ],
                                              ),
                                            ],
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
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.nama,
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
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
                                              'Status PPN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownButton<int>(
                                                value: model.selectedPPN,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    model.setselectedPPN(newValue ?? 0);
                                                  });
                                                },
                                                isExpanded: true,
                                                underline: Container(),
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 0,
                                                    child: Text('Non-PPN'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 1,
                                                    child: Text('PPN'),
                                                  ),
                                                ],
                                                icon: const Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                alignment: AlignmentDirectional.centerEnd, // Alignment for the icon
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      ],
                                    ),
                                  ),
                                  ListView.separated(
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                      left: 15,
                                      right: 19,
                                    ),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Colors.grey,
                                      );
                                    },
                                    itemCount: model.orderjualdetail.length,
                                    itemBuilder: (contect, index) {
                                      // final detailItems = model.detailItems[index];
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
                                                      IconButton(
                                                        onPressed: () async {
                                                          Navigator.pushNamed(
                                                            context,
                                                            Routes.updateeditDetailCatalog,
                                                            arguments: UpdateEditDetailOrderParam(
                                                              nomor: model.orderjualdetail[index].nomor,
                                                              mode: 'edit',
                                                              header: model.orderjual,
                                                              detailItem: model.orderjualdetail,
                                                            ),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red, // Warna ikon hapus
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: const Text('Hapus Data Detail Barang'),
                                                                content: const Text(
                                                                    'Apakah anda yakin menghapus detail barang ini?'),
                                                                actions: <Widget>[
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      TextButton(
                                                                        child: const Text('Ya'),
                                                                        onPressed: () async {
                                                                          bool success =
                                                                              await model.deleteOrderJualDetailModel(
                                                                            dihapusoleh: 1,
                                                                            nomor: model.orderjualdetail[index].nomor,
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
                                                                                  content: const Text(
                                                                                      'Detail Barang berhasil dihapus.'),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      child: const Text('OK'),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        model.initModel();
                                                                                        setState(() {
                                                                                          model.fetchOrderJual(
                                                                                              reload: true);
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
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Gagal'),
                                                                                  content: const Text(
                                                                                      'Gagal menghapus detail barang'),
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
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      left: 15,
                                      right: 19,
                                    ),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
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
                                                            controller: model.diskonprosentaseController,
                                                            onChanged: (value) {
                                                              model.hitung();
                                                            },
                                                            decoration: InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                              hintText: 'Masukkan diskon',
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
                                                            // StringUtils.rupiahFormat(
                                                            //   double.parse(diskonnominalController.text),
                                                            //   symbol: '',
                                                            // ),
                                                            model.diskonnominalController.text,
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
                                                    model.subtotalController.text =
                                                        '${model.orderjualdetail.fold(0, (sum, item) => sum + (item.subtotal ?? 0))}',
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
                                        Visibility(
                                          visible: model.selectedPPN == 1,
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
                                                          dppController.text,
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
                                                        const Expanded(
                                                          child: SizedBox(
                                                            height: 48,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  '11.00',
                                                                  style: TextStyle(
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
                                                                  ppnnominalController.text,
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
                                          controller: model.biayalainController,
                                          onChanged: (value) {
                                            model.hitung2();
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: 'Masukkan biaya lain',
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
                                                    model.totalController.text,
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
                                  Spacings.verSpace(164),
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
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.editkatalogproduk,
                                arguments: EditProdukKatalogParam(
                                  nomor: widget.param.nomor,
                                  mode: 'edit',
                                  header: model.orderjual,
                                  detailItem: model.orderjualdetail,
                                ),
                              );
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
                    Spacings.verSpace(28),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final bool response = await model.updateOrderJualOnlyModel(
                                nomormhrelasicust: '1',
                                ppnprosentase: "11",
                                statusppn: model.selectedPPN,
                                diskonprosentase: int.parse(model.diskonprosentaseController.text),
                                diskonnominal: _diskonnominal,
                                dpp: _dpp,
                                ppnnominal: _ppn,
                                totalbiaya: int.parse(model.biayalainController.text),
                                subtotal2: int.parse(model.subtotalController.text),
                                total: int.parse(model.totalController.text),
                                dibuatoleh: 1,
                                kode: model.kodeController.text,
                                tanggal: DateFormat('yyyy-MM-dd').format(model.selectedDate),
                              );
                              if (response) {
                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Succes'),
                                      content: const Text('Data Berhasil Diubah'),
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
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Gagal'),
                                      content: const Text('Data gagal diubah'),
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
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 144,
                                vertical: 16,
                              ),
                              backgroundColor: MjkColor.floatButtonSalesColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Simpan',
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customer(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }
}
