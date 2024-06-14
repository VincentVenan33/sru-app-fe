// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/kunjungan_get_data_dto_network.dart';
import 'package:sru/core/networks/update_kunjungan_dto.dart';
import 'package:sru/core/view_models/meet/detailpelanggan_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';

class DetailPelangganParam {
  const DetailPelangganParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailPelanggan extends ConsumerStatefulWidget {
  const DetailPelanggan({
    super.key,
    required this.param,
  });

  final DetailPelangganParam param;

  @override
  ConsumerState<DetailPelanggan> createState() => _DetailPelangganState();
}

class _DetailPelangganState extends ConsumerState<DetailPelanggan> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController pembahasanController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailPelangganViewModel>(
      model: DetailPelangganViewModel(
        kunjunganGetDataDTOApi: ref.read(kunjunganGetDataDTOApi),
        setUpdateKunjunganDTOApi: ref.read(setUpdateKunjunganDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (DetailPelangganViewModel model) => model.initModel(),
      builder: (_, DetailPelangganViewModel model, __) {
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
                                  backgroundColor: sruColor.backgroundAtas,
                                  leading: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.listpelanggan,
                                      );
                                    },
                                  ),
                                  title: Text(
                                    'Detail Pelanggan',
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
                                      left: 15,
                                      right: 19,
                                    ),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'Nama',
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
                                          controller: namaController,
                                          decoration: InputDecoration(
                                            hintText: model.kunjungan[0].customer,
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                        Spacings.verSpace(30),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kepentingan',
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
                                          controller: pembahasanController,
                                          decoration: InputDecoration(
                                            hintText: "${model.kunjungan[0].rencana}",
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                        Spacings.verSpace(30),
                                        const Row(
                                          children: [
                                            Text(
                                              'Lokasi',
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
                                            controller: locationController,
                                            decoration: InputDecoration(
                                              hintText: '${model.kunjungan[0].alamat}',
                                              contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                        Spacings.verSpace(30),
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
                                              hintText: model.kunjungan[0].keterangan,
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
                        onPressed: () async {
                          model.setBusy(true);
                          final hasPermissions = await Geolocator.checkPermission();
                          if (hasPermissions == LocationPermission.denied) {
                            await Geolocator.requestPermission();
                          } else {
                            try {
                              Position position =
                                  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                              double latitude = position.latitude;
                              double longitude = position.longitude;
                              model.setBusy(false);
                              if (model.kunjungan.isNotEmpty &&
                                  model.kunjungan[0].statuscheckin == 0 &&
                                  model.kunjungan[0].statuscheckout == 0) {
                                final bool response = await model.updateKunjungan(
                                  longitude: longitude,
                                  latitude: latitude,
                                  mode: "IN",
                                );
                                if (response) {
                                  // Jika gagal Check-in, tampilkan dialog gagal
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Gagal Check in'),
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
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Sukses'),
                                        content: const Text('Check In Berhasil'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pushNamed(context, Routes.listpelanggan);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else if (model.kunjungan.isNotEmpty &&
                                  model.kunjungan[0].statuscheckin == 1 &&
                                  model.kunjungan[0].statuscheckout == 0) {
                                final bool response = await model.updateKunjungan(
                                  longitude: 1,
                                  latitude: 1,
                                  mode: "OUT",
                                );
                                if (response) {
                                  // Jika gagal Check-out, tampilkan dialog gagal
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Gagal Check out'),
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
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Sukses'),
                                        content: const Text('Check Out Berhasil'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pushNamed(context, Routes.listpelanggan);
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 144,
                            vertical: 16,
                          ),
                          backgroundColor: model.kunjungan.isNotEmpty &&
                                  model.kunjungan[0].statuscheckin == 1 &&
                                  model.kunjungan[0].statuscheckout == 1
                              ? Colors.transparent // Tombol disembunyikan jika kedua status sudah 1
                              : sruColor.floatButtonSalesColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: model.kunjungan.isNotEmpty &&
                                  model.kunjungan[0].statuscheckin == 1 &&
                                  model.kunjungan[0].statuscheckout == 1
                              ? sruColor.transparent // Shadow disembunyikan jika kedua status sudah 1
                              : sruColor.transparent,
                          surfaceTintColor: model.kunjungan.isNotEmpty &&
                                  model.kunjungan[0].statuscheckin == 1 &&
                                  model.kunjungan[0].statuscheckout == 1
                              ? sruColor.transparent
                              : sruColor.floatButtonSalesColor,
                        ),
                        child: model.kunjungan.isNotEmpty &&
                                model.kunjungan[0].statuscheckin == 1 &&
                                model.kunjungan[0].statuscheckout == 1
                            ? const SizedBox.shrink() // Teks tombol disembunyikan jika kedua status sudah 1
                            : Text(
                                model.kunjungan.isNotEmpty &&
                                        model.kunjungan[0].statuscheckin == 1 &&
                                        model.kunjungan[0].statuscheckout == 0
                                    ? 'Check-out'
                                    : 'Check-in',
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
        );
      },
    );
  }
}
