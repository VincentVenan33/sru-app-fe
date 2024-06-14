import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/ui/shared/headers_sales.dart';
import 'package:sru/ui/shared/spacings.dart';

class ActivitySalesView extends ConsumerStatefulWidget {
  const ActivitySalesView({super.key});

  @override
  ConsumerState<ActivitySalesView> createState() => _ActivitySalesViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _ActivitySalesViewState extends ConsumerState<ActivitySalesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: sruColor.backgroundAtas),
              child: Column(
                children: [
                  const HeaderUser(
                    nama: '',
                    admingrup: '',
                  ),
                  Spacings.verSpace(20),
                  buildCardSales(context),
                ],
              ),
            ),
            Spacings.verSpace(20),
            dateCardSales(context),
            fullHorizontalLine(context),
            Spacings.verSpace(20),
            kegiatanCardSales(context),
            floatingButtonSales(context),
          ],
        ),
      ),
    );
  }

  Widget buildCardSales(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: sruColor.cardColorSales, // Set the background color here
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius here
                    ), // Set the background color here
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booking',
                              ),
                              Text(
                                '14 Items',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: Colors.black,
                                onPressed: () {
                                  // Add your notification icon's onPressed functionality here
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: sruColor.cardColorSales, // Set the background color here
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius here
                    ), // Set the background color here
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Penawaran'),
                              Text(
                                'Rp. 40.000',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                color: Colors.black,
                                onPressed: () {
                                  // Add your notification icon's onPressed functionality here
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
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey, // Set the line color to black
                    thickness: 2.0, // Set the line thickness as needed
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'REPORT DETAIL',
                  style: TextStyle(
                    color: Color(0xFF6A828B),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              )
            ],
          )
        ],
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

  Widget fullHorizontalLine(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black, // Set the line color to black
                    thickness: 2.0, // Set the line thickness as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kegiatanCardSales(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Column(
              children: [
                Row(
                  children: [Text('08.00')],
                ),
                Divider(
                  color: Colors.black, // Warna garis vertikal
                  thickness: 2, // Ketebalan garis vertikal
                  height: 20, // Tinggi garis vertikal
                ),
                Row(
                  children: [Text('11.00')],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xffF7F7F7), borderRadius: BorderRadius.circular(20)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Judul Kegiatan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                        Row(
                          children: [Icon(Icons.arrow_right_alt_outlined), Text('Judul Kegiatan Pertama')],
                        ),
                        Row(
                          children: [Icon(Icons.arrow_right_alt_outlined), Text('Judul Kegiatan Kedua')],
                        ),
                        Row(
                          children: [Icon(Icons.arrow_right_alt_outlined), Text('Judul Kegiatan Kedua')],
                        ),
                        Row(
                          children: [Icon(Icons.arrow_right_alt_outlined), Text('Judul Kegiatan Kedua')],
                        ),
                      ],
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

  Widget floatingButtonSales(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 16),
                // An example of the small floating action button.
                //
                // https://m3.material.io/components/floating-action-button/specs#669a1be8-7271-48cb-a74d-dd502d73bda4
                FloatingActionButton.small(
                  backgroundColor: sruColor.floatButtonSalesColor,
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
