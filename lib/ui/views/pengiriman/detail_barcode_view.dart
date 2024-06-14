import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/nota_jual_get_data_dto_network.dart';
import 'package:sru/core/networks/update_nota_jual_dto.dart';
import 'package:sru/core/view_models/pengiriman/detail_barcode_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';

class DetailBarcodeParam {
  const DetailBarcodeParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailBarcode extends ConsumerStatefulWidget {
  const DetailBarcode({
    super.key,
    required this.param,
  });
  final DetailBarcodeParam param;
  @override
  ConsumerState<DetailBarcode> createState() => _DetailBarcodeState();
}

class _DetailBarcodeState extends ConsumerState<DetailBarcode> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController pelangganController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController latlongController = TextEditingController();
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
    return ViewModel<DetailBarcodeViewModel>(
        model: DetailBarcodeViewModel(
          notaJualGetDataDTOApi: ref.read(notaJualGetDataDTOApi),
          setUpdateNotaJualDTOApi: ref.read(setUpdateNotaJualDTOApi),
          nomor: widget.param.nomor!,
        ),
        onModelReady: (DetailBarcodeViewModel model) => model.initModel(),
        builder: (_, DetailBarcodeViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: Stack(
              children: [
                UnfocusHelper(
                  child: SafeArea(
                    child: Scaffold(
                      backgroundColor: sruColor.white,
                      body: NotificationListener<UserScrollNotification>(
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
                              header: AnimatedSlide(
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
                                              menuIndex: 3,
                                              // 1 = Aktifitas Sales
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
                                      title: Text(
                                        'Detail Barcode',
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
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, i) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 39,
                                          left: 15,
                                          right: 19,
                                        ),
                                        child: Column(
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'Kode Surat Jalan',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: sruColor.lightBlack011,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.horSpace(5),
                                            TextFormField(
                                              controller: kodeController,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                hintText: model.notajual[0].kode,
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
                                            Spacings.verSpace(21),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Tanggal',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: sruColor.lightBlack011,
                                                  ),
                                                ),
                                                Spacings.verSpace(5),
                                                TextFormField(
                                                  controller: tanggalController,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                      hintText: DateFormat('dd/MM/yyyy').format(
                                                        DateTime.parse(model.notajual[0].tanggal ?? ''),
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
                                                Spacings.verSpace(21),
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Pelanggan',
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
                                                  controller: pelangganController,
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                    hintText: model.notajual[0].customer,
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
                                                Spacings.verSpace(21),
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
                                                Spacings.verSpace(21),
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Latlong',
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
                                                  height: 32,
                                                  child: TextFormField(
                                                    controller: latlongController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                      hintText:
                                                          '${model.notajual[0].latitudedatang}, ${model.notajual[0].longitudedatang}',
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
                                                ),
                                              ],
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
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.only(
                          left: 35,
                          right: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: model.notajual.isEmpty ||
                                        (model.notajual[0].statusberangkat == 1 &&
                                            model.notajual[0].statussampai == 1 &&
                                            model.notajual[0].statusdatang == 1)
                                    ? null
                                    : () async {
                                        model.setBusy(true);
                                        final hasPermissions = await Geolocator.checkPermission();
                                        if (hasPermissions == LocationPermission.denied) {
                                          await Geolocator.requestPermission();
                                        } else {
                                          try {
                                            Position position = await Geolocator.getCurrentPosition(
                                                desiredAccuracy: LocationAccuracy.high);
                                            double latitude = position.latitude;
                                            double longitude = position.longitude;
                                            model.setBusy(false);
                                            if (model.notajual[0].statusberangkat == 0 &&
                                                model.notajual[0].statussampai == 0 &&
                                                model.notajual[0].statusdatang == 0) {
                                              final bool response = await model.updateNotaJual(
                                                longitude: longitude,
                                                latitude: latitude,
                                                mode: "BERANGKAT",
                                                nomormhadmin: 1,
                                              );
                                              if (response) {
                                                // Jika gagal Check-in, tampilkan dialog gagal
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Gagal'),
                                                      content: const Text('Gagal Update Status Tracking'),
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
                                                // Jika berhasil Check-in, tampilkan dialog sukses
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Sukses'),
                                                      content: const Text('Update Status Tracking Berhasil'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text('OK'),
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
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            } else if (model.notajual[0].statusberangkat == 1 &&
                                                model.notajual[0].statussampai == 0 &&
                                                model.notajual[0].statusdatang == 0) {
                                              final bool response = await model.updateNotaJual(
                                                longitude: 1,
                                                latitude: 1,
                                                mode: "SAMPAI",
                                                nomormhadmin: 1,
                                              );
                                              if (response) {
                                                // Jika gagal Check-out, tampilkan dialog gagal
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Gagal'),
                                                      content: const Text('Gagal Update Status Tracking'),
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
                                                // Jika berhasil Check-out, tampilkan dialog sukses
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Sukses'),
                                                      content: const Text('Update Status Tracking Berhasil'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text('OK'),
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
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            } else if (model.notajual[0].statusberangkat == 1 &&
                                                model.notajual[0].statussampai == 1 &&
                                                model.notajual[0].statusdatang == 0) {
                                              final bool response = await model.updateNotaJual(
                                                longitude: 1,
                                                latitude: 1,
                                                mode: "Datang",
                                                nomormhadmin: 1,
                                              );
                                              if (response) {
                                                // Jika gagal Check-out, tampilkan dialog gagal
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Gagal'),
                                                      content: const Text('Gagal Update Status Tracking'),
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
                                                // Jika berhasil Check-out, tampilkan dialog sukses
                                                showDialog(
                                                  // ignore: use_build_context_synchronously
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Sukses'),
                                                      content: const Text('Update Status Tracking Berhasil'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text('OK'),
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
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            } else {
                                              // Tidak perlu melakukan apa-apa jika status sudah 1 semua
                                            }
                                          } catch (e) {
                                            showDialog(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text('Gagal mendapatkan Latlong'),
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
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 144, vertical: 16),
                                  backgroundColor: model.notajual.isNotEmpty &&
                                          model.notajual[0].statusberangkat == 1 &&
                                          model.notajual[0].statussampai == 1 &&
                                          model.notajual[0].statusdatang == 1
                                      ? Colors.transparent
                                      : sruColor.floatButtonSalesColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  shadowColor: model.notajual.isNotEmpty &&
                                          model.notajual[0].statusberangkat == 1 &&
                                          model.notajual[0].statussampai == 1 &&
                                          model.notajual[0].statusdatang == 1
                                      ? Colors.transparent
                                      : sruColor.transparent,
                                  surfaceTintColor: model.notajual.isNotEmpty &&
                                          model.notajual[0].statusberangkat == 1 &&
                                          model.notajual[0].statussampai == 1 &&
                                          model.notajual[0].statusdatang == 1
                                      ? Colors.transparent
                                      : sruColor.floatButtonSalesColor,
                                ),
                                child: !(model.notajual.isNotEmpty &&
                                        (model.notajual[0].statusberangkat == 0 ||
                                            model.notajual[0].statussampai == 0 ||
                                            model.notajual[0].statusdatang == 0))
                                    ? const SizedBox.shrink()
                                    : Text(
                                        model.notajual[0].statusberangkat == 0 &&
                                                model.notajual[0].statussampai == 0 &&
                                                model.notajual[0].statusdatang == 0
                                            ? 'Berangkat'
                                            : model.notajual[0].statusberangkat == 1 &&
                                                    model.notajual[0].statussampai == 0 &&
                                                    model.notajual[0].statusdatang == 0
                                                ? 'Sampai'
                                                : model.notajual[0].statusberangkat == 1 &&
                                                        model.notajual[0].statussampai == 1 &&
                                                        model.notajual[0].statusdatang == 0
                                                    ? 'Datang'
                                                    : '',
                                        style: const TextStyle(
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
                ),
                if (model.notajual.isNotEmpty && // Check if model.notajual has data
                    model.notajual[0].statusberangkat == 1 &&
                    model.notajual[0].statussampai == 1 &&
                    model.notajual[0].statusdatang == 1)
                  Container(
                    color: Colors.black.withOpacity(0.65), // Semi-transparent white background
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 50,
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                          color: sruColor.yellow003,
                        ),
                        child: const Text(
                          'Anda Sudah Mengantar Pesanan!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: sruColor.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
