import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/total_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/utilities/string_utils.dart';
import 'package:mjk_apps/core/view_models/aktifitas_sales/activityandcustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/headers_sales.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

class ActivitySalesView extends ConsumerStatefulWidget {
  const ActivitySalesView({super.key});

  @override
  ConsumerState<ActivitySalesView> createState() => _ActivitySalesViewState();
}

class _ActivitySalesViewState extends ConsumerState<ActivitySalesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModel<ActivitySalesViewModel>(
        model: ActivitySalesViewModel(
          totalGetDataDTOApi: ref.read(totalGetDataDTOApi),
          sharedPreferencesService: ref.read(sharedPrefProvider),
        ),
        onModelReady: (ActivitySalesViewModel model) => model.initModel(),
        builder: (_, ActivitySalesViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  body: RefreshIndicator(
                    onRefresh: () async => model.initModel(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(color: MjkColor.backgroundAtas),
                            child: Column(
                              children: [
                                HeaderUser(
                                  nama: model.nama ?? '',
                                  admingrup: model.admingrup ?? '',
                                ),
                                Spacings.verSpace(24),
                                buildCardSales(context, model),
                                Spacings.verSpace(25),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 24,
                              right: 24,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'AKTIVITAS AND PELANGGAN',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: MjkColor.lightBlack008,
                                  ),
                                ),
                                Spacings.verSpace(12),
                                const Divider(
                                  height: 1,
                                  color: MjkColor.lightBlack009,
                                ),
                                Spacings.verSpace(10),
                                Column(
                                  children: [
                                    // salesactivity(context),
                                    datacustomer(context, model),
                                    meet(context, model),
                                  ],
                                ),
                              ],
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
        });
  }

  Widget buildCardSales(BuildContext context, ActivitySalesViewModel model) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MjkColor.cardColorSales, // Set the background color here
                      borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                    ), // Set the background color here
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(Colors.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.omset,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Omset',
                                      style: TextStyle(
                                        color: MjkColor.lightBlack010,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios),
                                      color: MjkColor.lightBlack010,
                                      iconSize: 16,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.omset,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              StringUtils.rupiahFormat(
                                double.parse(model.totalMap["omzet"]?.total1 != null
                                    ? '${model.totalMap["omzet"]?.total1}'
                                    : '0'),
                                symbol: 'Rp. ',
                              ),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MjkColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MjkColor.cardColorSales, // Set the background color here
                      borderRadius: BorderRadius.circular(8), // Set the border radius here
                    ), // Set the background color here
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(Colors.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.piutang,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Piutang',
                                  style: TextStyle(
                                    color: MjkColor.lightBlack010,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  color: MjkColor.lightBlack010,
                                  iconSize: 16,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.piutang,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text(
                              StringUtils.rupiahFormat(
                                double.parse(model.totalMap["piutang"]?.total1 != null
                                    ? ' ${model.totalMap["piutang"]?.total1}'
                                    : '0'),
                                symbol: 'Rp. ',
                              ),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MjkColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // Widget salesactivity(BuildContext context) {
  //   return ViewModel<ActivitySalesViewModel>(
  //       model: ActivitySalesViewModel(
  //         totalGetDataDTOApi: ref.read(totalGetDataDTOApi),
  //       ),
  //       onModelReady: (ActivitySalesViewModel model) => model.initModel(),
  //       builder: (_, ActivitySalesViewModel model, __) {
  //         return Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(12),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(9),
  //                         border: Border.all(
  //                           color: MjkColor.lightBlack012,
  //                           width: 1,
  //                         ),
  //                       ),
  //                       child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           padding: const EdgeInsets.all(0),
  //                           backgroundColor: Color(Colors.transparent.value),
  //                           surfaceTintColor: Colors.white,
  //                           shadowColor: const Color(0x00000000),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(0),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.pushNamed(
  //                             context,
  //                             Routes.salesactivity,
  //                           );
  //                         },
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(12.0),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   const Text(
  //                                     'AKTIFITAS SALES',
  //                                     style: TextStyle(
  //                                       color: Colors.black,
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                   Spacings.verSpace(5),
  //                                   Text(
  //                                     'Total Aktivitas: ${model.totalMap["aktivitas"]?.total1}', // Menggunakan nilai total1 untuk tipe 'aktivitas'
  //                                     style: const TextStyle(
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w400,
  //                                       color: MjkColor.black,
  //                                     ),
  //                                   ),
  //                                   Spacings.verSpace(5),
  //                                   Text(
  //                                     'Sisa Aktivitas: ${model.totalMap["aktivitas"]?.total2}',
  //                                     style: const TextStyle(
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w400,
  //                                       color: MjkColor.black,
  //                                     ),
  //                                   ),
  //                                   Spacings.verSpace(5),
  //                                   Text(
  //                                     'Aktivitas Terbaru: ${model.totalMap["aktivitas"]?.total3}',
  //                                     style: const TextStyle(
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w400,
  //                                       color: MjkColor.black,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   IconButton(
  //                                     icon: const Icon(Icons.arrow_forward_ios),
  //                                     color: MjkColor.black,
  //                                     iconSize: 30,
  //                                     onPressed: () {
  //                                       Navigator.pushNamed(
  //                                         context,
  //                                         Routes.salesactivity,
  //                                       );
  //                                     },
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       });
  // }

  Widget datacustomer(BuildContext context, ActivitySalesViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: MjkColor.lightBlack012,
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Color(Colors.transparent.value),
                      surfaceTintColor: Colors.white,
                      shadowColor: const Color(0x00000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.customer,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'DATA PELANGGAN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Total Pelanggan: ${model.totalMap["customer"]?.total1}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Pelanggan Baru: ${model.totalMap["customer"]?.total2}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Pelanggan Tidak Aktif: ${model.totalMap["customer"]?.total3}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: MjkColor.black,
                                iconSize: 30,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.customer,
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget meet(BuildContext context, ActivitySalesViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: MjkColor.lightBlack012,
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Color(Colors.transparent.value),
                      surfaceTintColor: Colors.white,
                      shadowColor: const Color(0x00000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.listpelanggan,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'CHECK IN & CHECK OUT',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Check-in Terakhir: ${model.totalMap["checkinout"]?.total1}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Check-out Terakhir: ${model.totalMap["checkinout"]?.total2}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                              Spacings.verSpace(5),
                              Text(
                                'Sisa Pelanggan:  ${model.totalMap["checkinout"]?.total3}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: MjkColor.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: MjkColor.black,
                                iconSize: 30,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.listpelanggan,
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
