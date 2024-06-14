import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/models/get_data/get_data_dto.dart';
import 'package:sru/core/networks/create_kunjungan_dto.dart';
import 'package:sru/core/networks/get_data_dto_network.dart';
import 'package:sru/core/view_models/meet/createcheckinout_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';

class AddCheckInOut extends ConsumerStatefulWidget {
  const AddCheckInOut({super.key});

  @override
  ConsumerState<AddCheckInOut> createState() => _AddCheckInOutState();
}

class _AddCheckInOutState extends ConsumerState<AddCheckInOut> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController waktuinController = TextEditingController();
  final TextEditingController waktuoutController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController rencanaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
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
    }
    debugPrint('tanggal $_selectedDate');
  }

  late String _imageName = '';
  late String _imagePath = '';

  Future<String> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/imageupload/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File newImage = await image.copy(imagePath);
    return newImage.path;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageName = pickedImage.name;
        _imagePath = pickedImage.path;
        gambarController.text = pickedImage.name;
      });
    } else {
      debugPrint('No image selected.');
    }
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ViewModel<AddCheckInOutViewModel>(
      model: AddCheckInOutViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
        setKunjunganDTOApi: ref.read(setKunjunganDTOApi),
      ),
      onModelReady: (AddCheckInOutViewModel model) => model.initModel(),
      builder: (_, AddCheckInOutViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: sruColor.backgroundAtas,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.listpelanggan,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  title: const Text(
                    'Form Check In & Out',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 11,
                            left: 15,
                            right: 19,
                          ),
                          child: Column(
                            children: [
                              // const Row(
                              //   children: [
                              //     Text(
                              //       'Kode',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //         color: sruColor.lightBlack011,
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
                              //       hintText: '',
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
                              // Spacings.verSpace(18),
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
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.addpelanggan,
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
                              Spacings.verSpace(18),
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
                              Spacings.verSpace(18),
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
                                    surfaceTintColor: Colors.transparent,
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
                                        size: 16,
                                        color: sruColor.lightBlack022,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacings.verSpace(18),
                              // const Row(
                              //   children: [
                              //     Text(
                              //       'Waktu In',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 14,
                              //         color: sruColor.lightBlack011,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Spacings.verSpace(5),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: 32,
                              //   child: ElevatedButton(
                              //     onPressed: _showTimePickerwaktuin,
                              //     style: ElevatedButton.styleFrom(
                              //       padding: const EdgeInsets.only(
                              //         left: 10,
                              //       ),
                              //       side: const BorderSide(
                              //         color: Colors.grey,
                              //         width: 1.0,
                              //       ),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       backgroundColor: sruColor.white,
                              //     ),
                              //     child: TextFormField(
                              //       controller: waktuinController,
                              //       style: const TextStyle(
                              //         color: sruColor.black,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       decoration: InputDecoration(
                              //         hintText: DateFormat('HH:mm').format(DateTime.now()),
                              //         hintStyle: const TextStyle(
                              //           color: sruColor.black,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //         border: InputBorder.none,
                              //         focusedBorder: const OutlineInputBorder(
                              //           borderSide: BorderSide.none,
                              //         ),
                              //         enabledBorder: const OutlineInputBorder(
                              //           borderSide: BorderSide.none,
                              //         ),
                              //         suffixIcon: const Icon(
                              //           Icons.access_time_filled,
                              //           size: 16,
                              //           color: sruColor.lightBlack022,
                              //         ),
                              //       ),
                              //       enabled: false,
                              //       readOnly: true,
                              //     ),
                              //   ),
                              // ),
                              // Spacings.verSpace(18),
                              // const Row(
                              //   children: [
                              //     Text(
                              //       'Waktu Out',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 14,
                              //         color: sruColor.lightBlack011,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Spacings.verSpace(5),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: 32,
                              //   child: ElevatedButton(
                              //     onPressed: _showTimePickerwaktuout,
                              //     style: ElevatedButton.styleFrom(
                              //       padding: const EdgeInsets.only(
                              //         left: 10,
                              //       ),
                              //       side: const BorderSide(
                              //         color: Colors.grey,
                              //         width: 1.0,
                              //       ),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       backgroundColor: sruColor.white,
                              //     ),
                              //     child: TextFormField(
                              //       controller: waktuoutController,
                              //       style: const TextStyle(
                              //         color: sruColor.black,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       decoration: InputDecoration(
                              //         // contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                              //         hintText: DateFormat('HH:mm').format(DateTime.now()),
                              //         hintStyle: const TextStyle(
                              //           color: sruColor.black,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //         border: InputBorder.none,
                              //         focusedBorder: const OutlineInputBorder(
                              //           borderSide: BorderSide.none,
                              //         ),
                              //         enabledBorder: const OutlineInputBorder(
                              //           borderSide: BorderSide.none,
                              //         ),
                              //         suffixIcon: const Icon(
                              //           Icons.access_time_filled,
                              //           size: 16,
                              //           color: sruColor.lightBlack022,
                              //         ),
                              //       ),
                              //       enabled: false,
                              //       readOnly: true,
                              //     ),
                              //   ),
                              // ),
                              // Spacings.verSpace(18),
                              const Row(
                                children: [
                                  Text(
                                    'Judul',
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
                                controller: judulController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                  hintText: 'Tambah Judul..',
                                  hintStyle: const TextStyle(
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
                              Spacings.verSpace(18),
                              const Row(
                                children: [
                                  Text(
                                    'Rencana',
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
                                  controller: rencanaController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
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
                              Spacings.verSpace(18),
                              const Row(
                                children: [
                                  Text(
                                    'Gambar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: sruColor.lightBlack011,
                                    ),
                                  ),
                                ],
                              ),
                              Spacings.verSpace(5),
                              _imagePath.isNotEmpty
                                  ? Column(
                                      children: [
                                        Image.file(
                                          File(
                                            _imagePath,
                                          ),
                                          scale: 15,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          _imageName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        SizedBox(
                                          width: 192.551,
                                          height: 32,
                                          child: ElevatedButton(
                                            onPressed: _getImage,
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: const Text(
                                              'Choose a file',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 22.55),
                                        const Text(
                                          'Max. 5 MB',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                              // Spacings.verSpace(18),
                              // const Row(
                              //   children: [
                              //     Text(
                              //       'Location (Latitude)',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 14,
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
                              //     controller: latitudeController,
                              //     decoration: InputDecoration(
                              //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                              //       hintText: 'Latitude',
                              //       hintStyle: const TextStyle(
                              //         color: sruColor.lightBlack015,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       fillColor: sruColor.lightBlack019,
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
                              // Spacings.verSpace(18),
                              // const Row(
                              //   children: [
                              //     Text(
                              //       'Location (longitude)',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 14,
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
                              //     controller: longitudeController,
                              //     decoration: InputDecoration(
                              //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                              //       hintText: 'longitude',
                              //       hintStyle: const TextStyle(
                              //         color: sruColor.lightBlack015,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //       fillColor: sruColor.lightBlack019,
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
                              // Spacings.verSpace(35),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                                if (judulController.text.isEmpty ||
                                    DateFormat('yyyy-MM-dd').format(_selectedDate).isEmpty ||
                                    rencanaController.text.isEmpty ||
                                    gambarController.text.isEmpty) {
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
                                  return;
                                }
                                final bool response = await model.addCheckInOutModel(
                                  formatcode: "kode_kunjungan",
                                  kode: kodeController.text,
                                  tanggal: DateFormat('yyyy-MM-dd').format(_selectedDate),
                                  waktuin: DateFormat('HH:mm').format(DateTime.now()),
                                  waktuout: DateFormat('HH:mm').format(DateTime.now()),
                                  judul: judulController.text,
                                  rencana: rencanaController.text,
                                  gambar: gambarController.text,
                                  latitude: latitude,
                                  longitude: longitude,
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
                                              Navigator.pushNamed(
                                                context,
                                                Routes.listpelanggan,
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
                            backgroundColor: sruColor.floatButtonSalesColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Check-in',
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

  Widget sales(BuildContext context, GetDataContent item) {
    return Text(
      item.nama,
      style: const TextStyle(
        color: sruColor.black,
      ),
    );
  }

  TimeOfDay? waktuIn;
  TimeOfDay? waktuOut;

  // ignore: unused_element
  void _showTimePickerwaktuin() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Optional: Set initial time
    );

    if (pickedTime != null) {
      setState(() {
        waktuIn = pickedTime;
        waktuinController.text = _formatTime(pickedTime); // Format waktu menggunakan fungsi _formatTime
      });
      debugPrint("Waktu In telah dipilih: ${waktuinController.text}");
    }
  }

  String _formatTime(TimeOfDay time) {
    // Format jam dan menit ke dalam format "00:00"
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // ignore: unused_element
  void _showTimePickerwaktuout() async {
    if (waktuIn != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: waktuIn!, // Set initial time as waktuIn
      );

      if (pickedTime != null) {
        final DateTime waktuOutDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final DateTime waktuInDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          waktuIn!.hour,
          waktuIn!.minute,
        );

        if (waktuOutDateTime.isAfter(waktuInDateTime)) {
          setState(() {
            waktuOut = pickedTime;
            waktuoutController.text = _formatTime(pickedTime); // Format waktu menggunakan fungsi _formatTime
          });
          debugPrint("Waktu Out telah dipilih: ${waktuoutController.text}");
        } else {
          // Show error message or handle invalid selection
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Invalid Time"),
              content: const Text("Waktu out harus setelah waktu in."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    } else {
      // Show error message or handle invalid selection
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Selection"),
          content: const Text("Harap tentukan waktu in terlebih dahulu."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
