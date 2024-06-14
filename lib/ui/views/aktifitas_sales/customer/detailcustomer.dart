import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/customer/detailcustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

class DetailCustomerParam {
  const DetailCustomerParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailCustomer extends ConsumerStatefulWidget {
  const DetailCustomer({
    super.key,
    required this.param,
  });

  final DetailCustomerParam param;

  @override
  ConsumerState<DetailCustomer> createState() => _DetailCustomerState();
}

class _DetailCustomerState extends ConsumerState<DetailCustomer> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController gelarController = TextEditingController();
  final TextEditingController kategoricustomerController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController desaController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController kabupatenController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();
  final TextEditingController alamatktpController = TextEditingController();
  final TextEditingController jatuhtempoController = TextEditingController();
  final TextEditingController npwpController = TextEditingController();
  final TextEditingController kontakController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController plafonController = TextEditingController();
  final TextEditingController tipeoutletController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedDate = DateTime.now();
    });
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
    return ViewModel<DetailCustomerViewModel>(
      model: DetailCustomerViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (DetailCustomerViewModel model) => model.initModel(),
      builder: (_, DetailCustomerViewModel model, __) {
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
                                  leading: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.customer,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),
                                  title: Text(
                                    'Detail Pelanggan',
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
                                        Spacings.horSpace(5),
                                        TextFormField(
                                          controller: kodeController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.daftarcustomer[0].kode,
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
                                              'Nama',
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
                                          controller: namaController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].nama,
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                              'Gelar',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: gelarController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                              hintText: model.daftarcustomer[0].gelar,
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
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kategori Pelanggan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: kategoricustomerController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                              hintText: model.daftarcustomer[0].kategoricustomer,
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
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Alamat',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
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
                                            controller: alamatController,
                                            decoration: InputDecoration(
                                              hintText: model.daftarcustomer[0].alamat,
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
                                              'Desa/Kelurahan',
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.daftarcustomer[0].desa}',
                                                    style: const TextStyle(
                                                      color: MjkColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kecamatan',
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.daftarcustomer[0].kecamatan}',
                                                    style: const TextStyle(
                                                      color: MjkColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kabupaten/Kota',
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.daftarcustomer[0].kota}',
                                                    style: const TextStyle(
                                                      color: MjkColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              'Provinsi',
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.daftarcustomer[0].provinsi}',
                                                    style: const TextStyle(
                                                      color: MjkColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Telepon',
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
                                          controller: teleponController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].telepon,
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r'^(?:\+|0|62)?[0-9]+$',
                                              ),
                                            ),
                                          ],
                                          readOnly: true,
                                        ),
                                        Spacings.verSpace(14),
                                        // const Row(
                                        //   children: [
                                        //     Text(
                                        //       'Location (Latlong)',
                                        //       style: TextStyle(
                                        //         fontWeight: FontWeight.w400,
                                        //         fontSize: 14,
                                        //         color: MjkColor.lightBlack011,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Spacings.verSpace(5),
                                        // SizedBox(
                                        //   width: double.infinity,
                                        //   height: 32,
                                        //   child: TextFormField(
                                        //     controller: locationController,
                                        //     decoration: InputDecoration(
                                        //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                        //       hintText: '${model.daftarcustomer[0].shareloc}',
                                        //       hintStyle: const TextStyle(
                                        //         color: MjkColor.lightBlack015,
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w400,
                                        //       ),
                                        //       fillColor: MjkColor.lightBlack019,
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
                                        // Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'KTP',
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
                                          controller: ktpController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.daftarcustomer[0].ktp,
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
                                              'Alamat KTP',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
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
                                            controller: alamatktpController,
                                            decoration: InputDecoration(
                                              hintText: model.daftarcustomer[0].alamatktp,
                                              hintStyle: const TextStyle(
                                                color: MjkColor.black,
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
                                              'Jatuh Tempo',
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
                                          controller: jatuhtempoController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].jatuhtempo.toString(),
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          ],
                                          readOnly: true,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'No. NPWP',
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
                                          controller: npwpController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].npwp,
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                              'Kontak',
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
                                          controller: kontakController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].kontak,
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r'^(?:\+|0|62)?[0-9]+$',
                                              ),
                                            ),
                                          ],
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
                                            hintText: model.daftarcustomer[0].sales,
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
                                              'Plafon',
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
                                          scrollPadding: const EdgeInsets.all(8.0),
                                          controller: plafonController,
                                          decoration: InputDecoration(
                                            hintText: model.daftarcustomer[0].plafon.toString(),
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          ],
                                          readOnly: true,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Tipe Outlet',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: tipeoutletController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                              hintText: model.daftarcustomer[0].tipeoutlet,
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
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Keterangan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: MjkColor.lightBlack011,
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
                                              hintText: model.daftarcustomer[0].keterangan,
                                              hintStyle: const TextStyle(
                                                color: MjkColor.black,
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
                                        Spacings.verSpace(30),
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
