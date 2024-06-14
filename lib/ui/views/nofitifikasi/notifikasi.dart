import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';

class NotifikasiView extends ConsumerStatefulWidget {
  const NotifikasiView({super.key});

  @override
  ConsumerState<NotifikasiView> createState() => _NotifikasiViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _NotifikasiViewState extends ConsumerState<NotifikasiView> with TickerProviderStateMixin {
  final FocusNode stateFocus = FocusNode();

  // ignore: prefer_typing_uninitialized_variables
  var animation;
  // ignore: prefer_typing_uninitialized_variables
  var controller;

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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.navBarSales,
                  (route) => false,
                  arguments: NavbarSalesViewParam(
                    menuIndex: 1,
                    // 1 = Aktifitas Sales
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text(
              'Daftar Notifikasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: ListView.separated(
              separatorBuilder: (_, __) => Spacings.verSpace(12),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage(
                                  'assets/icons/notification-bing.png',
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kiriman Dalam Perjalan',
                              style: TextStyle(
                                fontSize: 15.38,
                                fontWeight: FontWeight.bold,
                                color: MjkColor.black,
                              ),
                            ),
                            Spacings.verSpace(15),
                            const Text(
                              'Kiriman sedang diantar oleh Ajeng Wigati',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: MjkColor.lightBlack010,
                              ),
                            ),
                            Spacings.verSpace(15),
                            const Text(
                              '2024/02/29  17:30:20',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: MjkColor.lightBlack010,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacings.verSpace(20),
                    const Column(
                      children: [
                        Divider(
                          height: 1,
                          color: MjkColor.lightBlack009,
                        ),
                      ],
                    ),
                    Spacings.verSpace(20.82),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
