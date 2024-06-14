import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

class UbahPasswordView extends ConsumerStatefulWidget {
  const UbahPasswordView({super.key});

  @override
  ConsumerState<UbahPasswordView> createState() => _UbahPasswordViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _UbahPasswordViewState extends ConsumerState<UbahPasswordView> with TickerProviderStateMixin {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordbaruController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnfocusHelper(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MjkColor.white,
          appBar: AppBar(
            backgroundColor: MjkColor.backgroundAtas,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.akun,
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text(
              'Ubah Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: Expanded(
                      child: Column(
                        children: [
                          Spacings.verSpace(20),
                          const Row(
                            children: [
                              Text(
                                'Password Lama',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MjkColor.lightBlack014,
                                ),
                              ),
                            ],
                          ),
                          Spacings.verSpace(5),
                          SizedBox(
                            width: double.infinity,
                            height: 32,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                hintStyle: const TextStyle(
                                  color: MjkColor.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: MjkColor.lightBlack014, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          Spacings.verSpace(40),
                          const Row(
                            children: [
                              Text(
                                'Password Baru*',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MjkColor.lightBlack014,
                                ),
                              ),
                            ],
                          ),
                          Spacings.verSpace(5),
                          SizedBox(
                            width: double.infinity,
                            height: 32,
                            child: TextFormField(
                              controller: passwordbaruController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                hintStyle: const TextStyle(
                                  color: MjkColor.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: MjkColor.lightBlack014, width: 1.0),
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
                                '*Tidak boleh sama dengan password lama, harus menggunakan kombinasi huruf \n kapital dan angka',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: MjkColor.lightBlack014,
                                ),
                              ),
                            ],
                          ),
                          Spacings.verSpace(350),
                          SizedBox(
                            width: double.infinity,
                            // height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.akun,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
