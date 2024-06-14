import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';

class AddSalesActivity extends ConsumerStatefulWidget {
  const AddSalesActivity({super.key});

  @override
  ConsumerState<AddSalesActivity> createState() => _AddSalesActivityState();
}

class _AddSalesActivityState extends ConsumerState<AddSalesActivity> {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jamawalController = TextEditingController();
  final TextEditingController jamakhirController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController judulkegiatanController = TextEditingController();
  final TextEditingController rencanakegiatanController = TextEditingController();
  final TextEditingController hasilkegiatanController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: MjkColor.backgroundAtas),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 44,
                      left: 17,
                      right: 16,
                      bottom: 12,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.black,
                          iconSize: 25,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tambah Kegiatan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Spacings.verSpace(11),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 19,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tanggal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: MjkColor.lightBlack011,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 32,
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
                                backgroundColor: MjkColor.white,
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
                                      color: MjkColor.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacings.verSpace(22),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 19,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: _showTimePickerawal,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MjkColor.green004, // Set background color to green
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 0,
                                  ), // Add padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // Apply border radius
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Jam Awal',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white, // Ensure text color is white for visibility
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 60,
                                      child: TextFormField(
                                        controller: jamawalController,
                                        decoration: const InputDecoration(
                                          hintText: '00.00',
                                          hintStyle: TextStyle(color: MjkColor.white),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                        readOnly: true,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _showTimePickerakhir,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MjkColor.lightBlack015, // Set background color to green
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5), // Add padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // Apply border radius
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Jam Akhir',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white, // Ensure text color is white for visibility
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 60,
                                      child: TextFormField(
                                        controller: jamakhirController,
                                        decoration: const InputDecoration(
                                          hintText: '00.00',
                                          hintStyle: TextStyle(color: MjkColor.white),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                        readOnly: true,
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacings.verSpace(22),
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
                          SizedBox(
                            width: double.infinity,
                            height: 32,
                            child: TextFormField(
                              controller: customerController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                hintText: 'Pilih Pelangan',
                                hintStyle: const TextStyle(
                                  color: MjkColor.lightBlack015,
                                  fontWeight: FontWeight.bold,
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
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Browse Customer',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: MjkColor.black,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: MjkColor.lightBlack017,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 270,
                                                      height: 38,
                                                      child: TextFormField(
                                                        controller: customerController,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 8,
                                                          ),
                                                          hintText: 'Pencarian',
                                                          hintStyle: const TextStyle(
                                                            color: MjkColor.lightBlack016,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 13,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(1000),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(1000),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                          prefixIcon: const Icon(
                                                            Icons.search_rounded,
                                                            size: 14,
                                                            color: MjkColor.lightBlack016,
                                                          ),
                                                          fillColor: MjkColor.lightBlack016,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(10),
                                                SizedBox(
                                                  width: 270,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 108,
                                                            height: 25,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: MjkColor.lightBlue006,
                                                            ),
                                                            child: const Text(
                                                              'C-BRI-00082',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: MjkColor.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            'ARGA KENCANA MANDIRI PT',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: MjkColor.black,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Jakarta,\nJakarta Barat',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w300,
                                                              color: MjkColor.lightBlack018,
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'Cabang\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: 'BUMIRAYA INT...',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'No. Telepon\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: '0812345789',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(12),
                                                      const Divider(
                                                        height: 1,
                                                        color: MjkColor.lightBlack009,
                                                      ),
                                                      Spacings.verSpace(12),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 270,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 108,
                                                            height: 25,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: MjkColor.lightBlue006,
                                                            ),
                                                            child: const Text(
                                                              'C-BRI-00009',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: MjkColor.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            'BAPAK DJAN FARIDZ',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: MjkColor.black,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Jl. Talang-Men..\nJakarta Barat',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w300,
                                                              color: MjkColor.lightBlack018,
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'Cabang\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: 'BUMIRAYA INT...',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'No. Telepon\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: '0812345789',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(12),
                                                      const Divider(
                                                        height: 1,
                                                        color: MjkColor.lightBlack009,
                                                      ),
                                                      Spacings.verSpace(12),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 270,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 108,
                                                            height: 25,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: MjkColor.lightBlue006,
                                                            ),
                                                            child: const Text(
                                                              'C-BRI-00126',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: MjkColor.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            'BAPAK AFIF',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: MjkColor.black,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Jakarta,\nJakarta Barat',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w300,
                                                              color: MjkColor.lightBlack018,
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'Cabang\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: 'BUMIRAYA INT...',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'No. Telepon\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: '0812345789',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(12),
                                                      const Divider(
                                                        height: 1,
                                                        color: MjkColor.lightBlack009,
                                                      ),
                                                      Spacings.verSpace(12),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 270,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 108,
                                                            height: 25,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: MjkColor.lightBlue006,
                                                            ),
                                                            child: const Text(
                                                              'C-BRI-00126',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: MjkColor.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            'BAPAK AGUS',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: MjkColor.black,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Jl. Anggrek Cen..\nJakarta Barat',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w300,
                                                              color: MjkColor.lightBlack018,
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'Cabang\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: 'BUMIRAYA INT...',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: const TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: 'No. Telepon\n',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: '0812345789',
                                                                  style: TextStyle(
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: MjkColor.lightBlack018,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(12),
                                                      const Divider(
                                                        height: 1,
                                                        color: MjkColor.lightBlack009,
                                                      ),
                                                      Spacings.verSpace(12),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  color: MjkColor.lightBlack016,
                                ),
                              ),
                            ),
                          ),
                          Spacings.verSpace(14),
                          const Row(
                            children: [
                              Text(
                                'Judul Kegiatan',
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
                            height: 32,
                            child: TextFormField(
                              controller: judulkegiatanController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                hintText: 'Tulis Judul Kegiatan...',
                                hintStyle: const TextStyle(
                                  color: MjkColor.lightBlack015,
                                  fontWeight: FontWeight.bold,
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
                          ),
                          Spacings.verSpace(14),
                          const Row(
                            children: [
                              Text(
                                'Rencana Kegiatan',
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
                            height: 32,
                            child: TextFormField(
                              controller: rencanakegiatanController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                hintText: 'Tulis Rencana Kegiatan...',
                                hintStyle: const TextStyle(
                                  color: MjkColor.lightBlack015,
                                  fontWeight: FontWeight.bold,
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
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.add_box_outlined),
                                  color: MjkColor.lightBlack016,
                                  onPressed: () {
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Detail Kegiatan',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: MjkColor.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: MjkColor.lightBlack017,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Judul Kegiatan',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: MjkColor.lightBlack011,
                                                    ),
                                                  ),
                                                  Spacings.verSpace(2),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 32,
                                                    child: TextFormField(
                                                      controller: judulkegiatanController,
                                                      decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                        hintText: 'Tulis Judul Kegiatan...',
                                                        hintStyle: const TextStyle(
                                                          color: MjkColor.lightBlack015,
                                                          fontWeight: FontWeight.bold,
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
                                                  ),
                                                  Spacings.verSpace(5),
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        'Hasil Kegiatan',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                          color: MjkColor.lightBlack011,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacings.verSpace(2),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    // height: 85,
                                                    child: TextFormField(
                                                      maxLines: null,
                                                      minLines: 3,
                                                      keyboardType: TextInputType.multiline,
                                                      scrollPadding: const EdgeInsets.all(8.0),
                                                      controller: hasilkegiatanController,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(
                                                            left: 16, right: 8, top: 6, bottom: 6),
                                                        hintText: 'Tulis Hasil Kegiatan',
                                                        hintStyle: const TextStyle(
                                                          color: MjkColor.lightBlack015,
                                                          fontWeight: FontWeight.bold,
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
                                                  ),
                                                  Spacings.verSpace(10),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          context,
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
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
                                                  Spacings.verSpace(5),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          context,
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: MjkColor.lightBlue006,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Tandai Selesai',
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
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Spacings.verSpace(14),
                          const Row(
                            children: [
                              Text(
                                'Gambar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: MjkColor.lightBlack011,
                                ),
                              ),
                            ],
                          ),
                          Spacings.verSpace(5),
                          const Text(
                            'kotak gambar',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: MjkColor.lightBlack011,
                            ),
                          ),
                          Spacings.verSpace(14),
                          const Row(
                            children: [
                              Text(
                                'Hasil Kegiatan',
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
                            // height: 85,
                            child: TextFormField(
                              maxLines: null,
                              minLines: 5,
                              keyboardType: TextInputType.multiline,
                              scrollPadding: const EdgeInsets.all(8.0),
                              controller: hasilkegiatanController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
                                hintText: 'Tulis Hasil Kegiatan',
                                hintStyle: const TextStyle(
                                  color: MjkColor.lightBlack015,
                                  fontWeight: FontWeight.bold,
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
                          ),
                          Spacings.verSpace(14),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.salesactivity,
                                );
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePickerawal() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Optional: Set initial time
    );

    if (pickedTime != null) {
      // Update the TextEditingController with the selected time
      // ignore: use_build_context_synchronously
      jamawalController.text = pickedTime.format(context);
    }
  }

  void _showTimePickerakhir() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Optional: Set initial time
    );

    if (pickedTime != null) {
      // Update the TextEditingController with the selected time
      // ignore: use_build_context_synchronously
      jamakhirController.text = pickedTime.format(context);
    }
  }
}
