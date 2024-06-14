import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/networks/create_order_jual_detail_bonus_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/utilities/string_utils.dart';
import 'package:sru/core/view_models/orderjual/addorderjual_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';
import 'package:sru/ui/views/orderjual/edititemdetail.dart';

class AddOrderJual extends ConsumerStatefulWidget {
  const AddOrderJual({super.key});

  @override
  ConsumerState<AddOrderJual> createState() => _AddOrderJualState();
}

class _AddOrderJualState extends ConsumerState<AddOrderJual> {
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
  late DateTime _selectedDate;

  int _subtotal = 0;
  int _diskonnominal = 0;
  int _dpp = 0;
  int _ppn = 0;
  int _biayalain = 0;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    diskonprosentaseController.addListener(hitung);
    subtotalController.addListener(hitung);
    biayalainController.addListener(hitung2);
    _selectedDate = DateTime.now();
  }

  void hitung() {
    setState(() {
      double disc1Percentage = (double.tryParse(diskonprosentaseController.text) ?? 0) / 100;

      _subtotal = int.parse(subtotalController.text);
      debugPrint('totalSubtotal $_subtotal');

      _diskonnominal = (_subtotal * disc1Percentage).toInt();
      diskonnominalController.text = _diskonnominal.toString();
      if (selectedPPN == '0') {
        _ppn = 0;
      } else {
        _ppn = (_dpp * 0.11).toInt();
      }
      _dpp = _subtotal - _diskonnominal.toInt();
      dppController.text = _dpp.toString();
      ppnnominalController.text = _ppn.toString();
      debugPrint('dpp : $_dpp');
      debugPrint('ppn : $_ppn');
      _biayalain = 0;
      debugPrint('biayalain : $_biayalain');
      _total = _dpp + _ppn + _biayalain;
      totalController.text = _total.toString();
    });
  }

  void hitung2() {
    setState(() {
      _dpp = int.parse(dppController.text);
      debugPrint('dpp : $_dpp');
      _ppn = int.parse(ppnnominalController.text);
      debugPrint('ppn : $_ppn');
      _biayalain = int.parse(biayalainController.text);
      _total = _dpp + _ppn + _biayalain;
      totalController.text = _total.toString();
    });
  }

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
      debugPrint('tanggal $_selectedDate');
    }
  }

  String? selectedPPN = '0';

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<AddOrderJualViewModel>(
      model: AddOrderJualViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
        sharedPreferencesService: ref.read(sharedPrefProvider),
        setOrderJualDetailBonusDTOApi: ref.read(setOrderJualDetailBonusDTOApi),
      ),
      onModelReady: (AddOrderJualViewModel model) => model.initModel(),
      builder: (_, AddOrderJualViewModel model, __) {
        return UnfocusHelper(
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
                            Column(
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
                                          'Tambah Order Jual',
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
                                      // const Row(
                                      //   children: [
                                      //     Text(
                                      //       'Kode*',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w400,
                                      //         color: sruColor.lightBlack011,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Spacings.verSpace(5),
                                      // SizedBox(
                                      //   width: double.infinity,
                                      //   height: 32,
                                      //   child: TextFormField(
                                      //     controller: kodeController,
                                      //     decoration: InputDecoration(
                                      //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                      //       hintText: 'C-BRI-00009',
                                      //       hintStyle: const TextStyle(
                                      //         color: sruColor.lightBlack011,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //       fillColor: sruColor.lightBlack019, // Add this line to set the background color
                                      //       filled: true,
                                      //       enabledBorder: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(8.0),
                                      //         borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(8.0),
                                      //         borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                      //       ),
                                      //     ),
                                      //     readOnly: true,
                                      //   ),
                                      // ),
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
                                            backgroundColor: sruColor.transparent,
                                            surfaceTintColor: sruColor.transparent,
                                            shadowColor: const Color(0x00000000),
                                          ),
                                          onPressed: _pickDate,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: sruColor.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.calendar_month,
                                                color: sruColor.lightBlack016,
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
                                              color: sruColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addpelangganorderjual,
                                            arguments: model,
                                          ).then((withResponse) {
                                            if (withResponse == false) {
                                              return;
                                            }
                                            if (model.selectedCustomer != null) {
                                              GetDataContent value = model.selectedCustomer!;
                                              setState(() {
                                                customerController.text = value.nama;
                                              });
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(sruColor.transparent.value),
                                          surfaceTintColor: sruColor.transparent,
                                          shadowColor: sruColor.transparent,
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
                                              customerController.text,
                                              style: const TextStyle(
                                                color: sruColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      customerController.clear();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                    color: sruColor.lightBlack014,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.search,
                                                  color: sruColor.lightBlack014,
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
                                          hintText: model.nama,
                                          hintStyle: const TextStyle(
                                            color: sruColor.black,
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
                                              color: sruColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButton<String>(
                                              value: selectedPPN,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedPPN = newValue;
                                                });
                                              },
                                              isExpanded: true, // Make the dropdown take the full width
                                              underline: Container(), // Remove default underline
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '0',
                                                  child: Text('Non-PPN'),
                                                ),
                                                DropdownMenuItem(
                                                  value: '1',
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'DETAIL BARANG',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: sruColor.lightBlack008,
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
                                                    title: const Text('Hapus Barang'),
                                                    content: const Text(
                                                        'Apakah anda yakin mengahapus semua detail barang ini?'),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            child: const Text('Ya'),
                                                            onPressed: () {
                                                              setState(() {
                                                                model.clearItem();
                                                                int totalSubtotal = model.detailItems
                                                                    .fold(0, (sum, item) => sum + (item.subtotal));
                                                                double disc1Percentage =
                                                                    (double.tryParse(diskonprosentaseController.text) ??
                                                                            0) /
                                                                        100;

                                                                _subtotal = totalSubtotal;
                                                                debugPrint('totalSubtotal $_diskonnominal');

                                                                _diskonnominal = (_subtotal * disc1Percentage).toInt();
                                                                diskonnominalController.text =
                                                                    _diskonnominal.toString();
                                                              });
                                                              Navigator.pop(context);
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
                                  itemCount: model.detailItems.length,
                                  itemBuilder: (contect, index) {
                                    final detailItems = model.detailItems[index];
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
                                                        '${detailItems.kode}',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                          color: sruColor.black,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        // final bool response = await model.editItemtoList(
                                                        //   CreateOrderJualDetailRequest(
                                                        //     nomormhbarang: detailItems.nomormhbarang,
                                                        //     nomormhsatuan: detailItems.nomormhsatuan,
                                                        //     kode: detailItems.kode,
                                                        //     nama: detailItems.nama,
                                                        //     qty: detailItems.qty,
                                                        //     netto: detailItems.netto,
                                                        //     disctotal: detailItems.disctotal,
                                                        //     discdirect: detailItems.discdirect,
                                                        //     disc3: detailItems.disc3,
                                                        //     disc2: detailItems.disc2,
                                                        //     disc1: detailItems.disc1,
                                                        //     satuanqty: detailItems.satuanqty,
                                                        //     isi: detailItems.isi,
                                                        //     satuanisi: detailItems.satuanisi,
                                                        //     harga: detailItems.harga,
                                                        //     subtotal: detailItems.subtotal,
                                                        //     konversisatuan: detailItems.konversisatuan,
                                                        //   ),
                                                        // );

                                                        // if (response) {
                                                        Navigator.pushNamed(
                                                          // ignore: use_build_context_synchronously
                                                          context,
                                                          Routes.editDetailCatalog,
                                                          arguments: EditDetailOrderParam(
                                                              nomor: index, mode: 'edit', detailItem: detailItems),
                                                        );
                                                        // }
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
                                                              title: const Text('Hapus Barang'),
                                                              content: const Text(
                                                                  'Apakah anda yakin mengahapus detail barang ini?'),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      child: const Text('Ya'),
                                                                      onPressed: () {
                                                                        model.clearItemAtIndex(index);
                                                                        setState(() {
                                                                          int totalSubtotal = model.detailItems.fold(
                                                                              0, (sum, item) => sum + (item.subtotal));
                                                                          double disc1Percentage = (double.tryParse(
                                                                                      diskonprosentaseController
                                                                                          .text) ??
                                                                                  0) /
                                                                              100;

                                                                          _subtotal = totalSubtotal;
                                                                          debugPrint('totalSubtotal $_diskonnominal');

                                                                          _diskonnominal =
                                                                              (_subtotal * disc1Percentage).toInt();
                                                                          diskonnominalController.text =
                                                                              _diskonnominal.toString();
                                                                        });
                                                                        Navigator.pop(context);
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
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Text(
                                                  '${detailItems.nama}',
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color: sruColor.black,
                                                  ),
                                                ),
                                                Spacings.verSpace(5),
                                                Text(
                                                  '${detailItems.qty} ${detailItems.satuanqty}',
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
                                                    double.parse(model.detailItems[index].subtotal != null
                                                        ? '${model.detailItems[index].subtotal}'
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
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon',
                                                          hintStyle: const TextStyle(
                                                            color: sruColor.lightBlack015,
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
                                                          diskonnominalController.text,
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
                                                  subtotalController.text =
                                                      '${model.detailItems.fold(0, (sum, item) => sum + (item.subtotal))}',
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
                                      Visibility(
                                        visible: selectedPPN == '1',
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
                                                        dppController.text,
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
                                                                ppnnominalController.text,
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
                                          hintText: 'Masukkan biaya lain',
                                          hintStyle: const TextStyle(
                                            color: sruColor.lightBlack015,
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
                                                  totalController.text,
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
                                Routes.katalogproduk,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 124,
                                vertical: 16,
                              ),
                              backgroundColor: sruColor.floatButtonSalesColor,
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
                    if (model.detailItems.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (DateFormat('yyyy-MM-dd').format(_selectedDate).isEmpty ||
                                    customerController.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Semua field harus diisi'),
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
                                  return; // Stop further execution
                                }
                                final bool response = await model.addOrderJualModel(
                                  formatcode: "kode_penjualan_order",
                                  nomormhcustomer: '1',
                                  ppnprosentase: "11",
                                  statusppn: int.tryParse(selectedPPN ?? '0') ?? 0,
                                  diskonprosentase: int.parse(diskonprosentaseController.text),
                                  diskonnominal: _diskonnominal,
                                  dpp: _dpp,
                                  ppnnominal: _ppn,
                                  totalbiaya: int.parse(biayalainController.text),
                                  subtotal2: int.parse(subtotalController.text),
                                  total: int.parse(totalController.text),
                                  kode: "tes",
                                  dibuatoleh: 1,
                                  tanggal: DateFormat('yyyy-MM-dd').format(_selectedDate),
                                );
                                if (response) {
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Data Gagal Disimpan'),
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
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Succes'),
                                        content: const Text('Data Berhasil Disimpan'),
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
                                              model.clearItem();
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
                                backgroundColor: sruColor.floatButtonSalesColor,
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
        color: sruColor.black,
      ),
    );
  }
}
