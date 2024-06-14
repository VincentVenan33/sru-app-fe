import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/models/get_data/get_data_dto.dart';
import 'package:mjk_apps/core/networks/create_customer_dto.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/customer/addcustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

class AddCustomer extends ConsumerStatefulWidget {
  const AddCustomer({super.key});

  @override
  ConsumerState<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends ConsumerState<AddCustomer> {
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
  // final TextEditingController npwpController = TextEditingController();
  final TextEditingController kontakController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController plafonController = TextEditingController();
  final TextEditingController tipeoutletController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final npwpController = MaskedTextController(mask: '00.000.000.0-000.000');
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
    return ViewModel<AddCustomerViewModel>(
      model: AddCustomerViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
        setCustomerDTOApi: ref.read(setCustomerDTOApi),
      ),
      onModelReady: (AddCustomerViewModel model) => model.initModel(),
      builder: (_, AddCustomerViewModel model, __) {
        return UnfocusHelper(
          child: SafeArea(
            child: Scaffold(
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
                                    'Tambah Pelanggan',
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
                                        // const Row(
                                        //   children: [
                                        //     Text(
                                        //       'Kode*',
                                        //       style: TextStyle(
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: MjkColor.lightBlack011,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Spacings.horSpace(5),
                                        // SizedBox(
                                        //   width: double.infinity,
                                        //   height: 32,
                                        //   child: TextFormField(
                                        //     controller: kodeController,
                                        //     decoration: InputDecoration(
                                        //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                        //       hintText: 'OL-BRI/2212/00001',
                                        //       hintStyle: const TextStyle(
                                        //         color: MjkColor.lightBlack011,
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //       fillColor: MjkColor.lightBlack019, // Add this line to set the background color
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
                                              'Nama*',
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
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.black,
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Gelar*',
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField<GetDataContent>(
                                                value: model
                                                    .selectedGelar, // Ensure this matches the value of an item in the list
                                                hint: const Text('Cari...'),
                                                items: model.gelar
                                                    .map((item) => DropdownMenuItem<GetDataContent>(
                                                          value: item,
                                                          child: gelar(
                                                            context,
                                                            item,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    model.setselectedgelar(value);
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                              padding: EdgeInsets.zero,
                                              onPressed: () {},
                                              icon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    model.setselectedgelar(null);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.refresh_outlined,
                                                  color: MjkColor.lightBlack014,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kategori Pelanggan*',
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField<GetDataContent>(
                                                value: model
                                                    .selectedKategoriCustomer, // Ensure this matches the value of an item in the list
                                                hint: const Text('Cari...'),
                                                items: model.kategoricustomer
                                                    .map(
                                                      (item) => DropdownMenuItem<GetDataContent>(
                                                        value: item,
                                                        child: kategoriCustomer(
                                                          context,
                                                          item,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    model.setselectedkategori(value);
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                              padding: EdgeInsets.zero,
                                              onPressed: () {},
                                              icon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    model.setselectedkategori(null);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.refresh_outlined,
                                                  color: MjkColor.lightBlack014,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Alamat*',
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
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Desa/Kelurahan*',
                                            ),
                                            Spacings.verSpace(5),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.adddesa,
                                                  arguments: model,
                                                ).then((withResponse) {
                                                  if (withResponse == false) {
                                                    return;
                                                  }
                                                  if (model.selectedDesa != null) {
                                                    GetDataContent value = model.selectedDesa!;
                                                    String? kecamatan = value.kecamatan;
                                                    String? kota = value.kota;
                                                    String? provinsi = value.provinsi;
                                                    setState(() {
                                                      desaController.text = value.nama;
                                                      kecamatanController.text = kecamatan!;
                                                      kabupatenController.text = kota!;
                                                      provinsiController.text = provinsi!;
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
                                                  SizedBox(
                                                    width: 130,
                                                    child: Text(
                                                      desaController.text,
                                                      style: const TextStyle(
                                                        color: MjkColor.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            desaController.clear();
                                                            kecamatanController.clear();
                                                            kabupatenController.clear();
                                                            provinsiController.clear();
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
                                          ],
                                        ),
                                        Spacings.verSpace(14),
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
                                            Text(
                                              kecamatanController.text,
                                              style: const TextStyle(
                                                color: MjkColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
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
                                            Text(
                                              kabupatenController.text,
                                              style: const TextStyle(
                                                color: MjkColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
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
                                            Text(
                                              provinsiController.text,
                                              style: const TextStyle(
                                                color: MjkColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Telepon*',
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
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: 'Telepon Customer',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.lightBlack015,
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r'^(?:\+|0|62)?[0-9]+$',
                                              ),
                                            ),
                                          ],
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
                                        //       hintText: 'Latlong Customer',
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
                                              'KTP*',
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
                                          maxLength: 16,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(
                                              left: 16,
                                              top: 6,
                                              bottom: 6,
                                            ),
                                            hintText: 'No. KTP Customer',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.lightBlack015,
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
                                            counterText: "",
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
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'No. KTP tidak boleh kosong';
                                            } else if (value.length != 16) {
                                              return 'No. KTP harus terdiri dari 16 digit';
                                            }
                                            return null; // Return null jika valid
                                          },
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
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Jatuh Tempo*',
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
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: 'Jatuh Tempo (Hari)',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.lightBlack015,
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
                                          keyboardType:
                                              const TextInputType.numberWithOptions(signed: true, decimal: false),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          ],
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
                                          maxLength: 20,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: 'No. NPWP Customer',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.lightBlack015,
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
                                            counterText: '',
                                          ),
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Kontak*',
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
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: 'Kontak Customer',
                                            hintStyle: const TextStyle(
                                              color: MjkColor.lightBlack015,
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
                                              'Plafon*',
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
                                          maxLength: 27,
                                          scrollPadding: const EdgeInsets.all(8.0),
                                          controller: plafonController,
                                          decoration: InputDecoration(
                                            hintText: 'Plafon',
                                            hintStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: MjkColor.black,
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
                                            counterText: '',
                                          ),
                                          keyboardType: const TextInputType.numberWithOptions(
                                            signed: true,
                                            decimal: true,
                                          ),
                                          inputFormatters: [ThousandSeparatorInputFormatter()],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Tipe Outlet*',
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: DropdownButtonFormField<GetDataContent>(
                                                value: model
                                                    .selectedTipeOutlet, // Ensure this matches the value of an item in the list
                                                hint: const Text('Cari...'),
                                                items: model.tipeoutlet
                                                    .map((item) => DropdownMenuItem<GetDataContent>(
                                                          value: item,
                                                          child: tipeOutlet(
                                                            context,
                                                            item,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    model.setselectedtipeoutlet(value);
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
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
                                              padding: EdgeInsets.zero,
                                              onPressed: () {},
                                              icon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    model.setselectedtipeoutlet(null);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.refresh_outlined,
                                                  color: MjkColor.lightBlack014,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                          ),
                                        ),
                                        Spacings.verSpace(84),
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
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          model.setBusy(true);
                          String text = plafonController.text;
                          String tanpaTitik = text.replaceAll(ThousandSeparatorInputFormatter.separator, '');
                          final hasPermissions = await Geolocator.checkPermission();
                          if (hasPermissions == LocationPermission.denied) {
                            await Geolocator.requestPermission();
                          } else {
                            try {
                              Position position =
                                  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                              double latitude = position.latitude;
                              double longitude = position.longitude;
                              String latlong = '$latitude,$longitude';
                              model.setBusy(false);

                              if (namaController.text.isEmpty ||
                                  jatuhtempoController.text.isEmpty ||
                                  plafonController.text.isEmpty ||
                                  alamatController.text.isEmpty ||
                                  teleponController.text.isEmpty ||
                                  ktpController.text.isEmpty ||
                                  jatuhtempoController.text.isEmpty ||
                                  plafonController.text.isEmpty ||
                                  kontakController.text.isEmpty ||
                                  model.selectedGelar == null ||
                                  model.selectedKategoriCustomer == null ||
                                  model.selectedTipeOutlet == null) {
                                showDialog(
                                  // ignore: use_build_context_synchronously
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

                              final bool response = await model.addCustomertModel(
                                nomormhkelurahan: 0,
                                nomormhkecamatan: 0,
                                nomormhkota: 0,
                                nomormhprovinsi: 0,
                                jenis: 1,
                                kode: kodeController.text,
                                nama: namaController.text,
                                jatuhtempo: jatuhtempoController.text,
                                plafon: tanpaTitik,
                                formatcode: 'kode_master_customer',
                                alamat: alamatController.text,
                                alamatktp: alamatController.text,
                                shareloc: latlong,
                                nohp: teleponController.text,
                                hp: "hp",
                                ktp: ktpController.text,
                                npwp: npwpController.text,
                                kontak: kontakController.text,
                                keterangan: keteranganController.text,
                                dibuatoleh: 1,
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
                                      title: const Text('Berhasil'),
                                      content: const Text('Data Berhasil Disimpan'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.customer,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget kategoriCustomer(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }

  Widget tipeOutlet(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }

  Widget gelar(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }

  Widget sales(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }

  Widget desa(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: MjkColor.black,
      ),
    );
  }
}

class ThousandSeparatorInputFormatter extends TextInputFormatter {
  static const separator = '.'; // Karakter pemisah

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Ketika teks kosong, langsung kembalikan nilai baru
    if (newValue.text == '') {
      return newValue;
    }

    // Hapus karakter separator yang sudah ada
    String text = newValue.text.replaceAll(separator, '');

    // Tambahkan pemisah
    var newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 3 == 0) newText.write(separator);
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
