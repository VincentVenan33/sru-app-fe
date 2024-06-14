import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';

class SalesActivityView extends ConsumerStatefulWidget {
  const SalesActivityView({super.key});

  @override
  ConsumerState<SalesActivityView> createState() => _SalesActivityViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _SalesActivityViewState extends ConsumerState<SalesActivityView> with TickerProviderStateMixin {
  final FocusNode stateFocus = FocusNode();

  // ignore: prefer_typing_uninitialized_variables
  var animation;
  // ignore: prefer_typing_uninitialized_variables
  var controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innnerBoxIsScrolled) {
            if (innnerBoxIsScrolled) {
              /* Animation */
              controller = AnimationController(
                vsync: this,
                duration: const Duration(
                  seconds: 1,
                ),
              );
              animation = Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(controller);
              /* Animation */
              controller.forward();
            }
            return <Widget>[
              SliverAppBar(
                expandedHeight: 90,
                floating: false,
                pinned: true,
                backgroundColor: sruColor.backgroundAtas,
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                toolbarHeight: 90,
                centerTitle: false,
                elevation: 0.0,
                leadingWidth: 0.0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (innnerBoxIsScrolled == true)
                      FadeTransition(
                        opacity: animation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacings.verSpace(10),
                            Container(
                              decoration: const BoxDecoration(color: sruColor.backgroundAtas),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      // top: 20,
                                      left: 17,
                                      right: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          color: Colors.black,
                                          iconSize: 20,
                                          onPressed: () {},
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Aktivitas Sales',
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
                            Spacings.verSpace(20),
                          ],
                        ),
                      ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: sruColor.backgroundAtas),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 17,
                                right: 16,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    color: Colors.black,
                                    iconSize: 25,
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
                                  ),
                                  const Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Aktivitas Sales',
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
                      Spacings.verSpace(20),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'KEGIATAN HARI INI',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: sruColor.lightBlack008,
                              ),
                            ),
                            Spacings.verSpace(12),
                            const Divider(
                              height: 1,
                              color: sruColor.lightBlack009,
                            ),
                            Spacings.verSpace(14),
                          ],
                        ),
                      ),
                    ),
                    dateCardSales(context),
                    Spacings.verSpace(14),
                    const Divider(
                      height: 1,
                      color: sruColor.lightBlack009,
                    ),
                    Spacings.verSpace(20),
                    kegiatanCardSales(context),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key("customer_FAB"),
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.addsalesactivity,
            );
          },
          backgroundColor: sruColor.floatButtonSalesColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 31.5,
          ),
        ),
      ),
    );
  }

  Widget dateCardSales(BuildContext context) {
    List<Map<String, dynamic>> dateInfoList = [];

    // Define your currentDate here
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime nextDate = currentDate.add(Duration(days: i));

      // Format the date to get the day name and number
      String dayName = DateFormat('EE').format(nextDate); // Full day name
      int dayNumber = nextDate.day; // Day number

      // Save the day name and number to the array
      dateInfoList.add({
        'dayName': dayName,
        'dayNumber': dayNumber,
      });
    }

    // Print the array for demonstration
    // print(dateInfoList);

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dateInfoList.map((dateInfo) {
          DateTime date = currentDate.add(Duration(days: dateInfoList.indexOf(dateInfo)));

          bool isToday = date.isAtSameMomentAs(currentDate);
          return Column(
            children: [
              Text(
                dateInfo['dayName'],
                style: TextStyle(
                  color: isToday ? const Color(0xFF000000) : const Color(0xFF868897),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                dateInfo['dayNumber'].toString(),
                style: TextStyle(
                  color: isToday ? const Color(0xFF000000) : const Color(0xFF868897),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget kegiatanCardSales(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [Text('08.00')],
                  ),
                  Spacings.verSpace(7),
                  Container(
                    height: 78,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: sruColor.lightBlack009),
                      ),
                    ),
                  ),
                  Spacings.verSpace(7),
                  const Row(
                    children: [Text('11.00')],
                  )
                ],
              ),
              Spacings.horSpace(18),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer - Judul Kegiatan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: sruColor.lightBlack010,
                              size: 15,
                            ),
                          ],
                        ),
                        Spacings.verSpace(10),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Pertama',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.green003,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Kedua',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.lightBlack013,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Ketiga',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.lightBlack013,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacings.verSpace(24),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [Text('13.00')],
                  ),
                  Spacings.verSpace(7),
                  Container(
                    height: 78,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: sruColor.lightBlack009),
                      ),
                    ),
                  ),
                  Spacings.verSpace(7),
                  const Row(
                    children: [Text('15.00')],
                  )
                ],
              ),
              Spacings.horSpace(18),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer - Judul Kegiatan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: sruColor.lightBlack010,
                              size: 15,
                            ),
                          ],
                        ),
                        Spacings.verSpace(10),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Pertama',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.green003,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Kedua',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.lightBlack013,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacings.verSpace(24),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [Text('16.00')],
                  ),
                  Spacings.verSpace(7),
                  Container(
                    height: 78,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: sruColor.lightBlack009),
                      ),
                    ),
                  ),
                  Spacings.verSpace(7),
                  const Row(
                    children: [Text('17.00')],
                  )
                ],
              ),
              Spacings.horSpace(18),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer - Judul Kegiatan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: sruColor.lightBlack010,
                              size: 15,
                            ),
                          ],
                        ),
                        Spacings.verSpace(10),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Pertama',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.green003,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Kedua',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.lightBlack013,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 9,
                              color: sruColor.lightBlack013,
                            ),
                            Text(
                              'Judul Kegiatan Kedua',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: sruColor.lightBlack013,
                              ),
                            )
                          ],
                        ),
                      ],
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
}
