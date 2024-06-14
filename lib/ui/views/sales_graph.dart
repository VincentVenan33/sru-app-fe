import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/utilities/text_styles.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';

class SalesGraph extends StatefulWidget {
  const SalesGraph({super.key});

  @override
  State<SalesGraph> createState() => _SalesGraphState();
}

class _SalesGraphState extends State<SalesGraph> with TickerProviderStateMixin {
  bool _isShown = false;
  int maxYData = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  final Color leftBarColor = const Color(0xff990000); // Pembelian
  final Color rightBarColor = const Color(0xffff0000); // Penjualan
  final double width = 12;

  late List<charts.Series<ChartData, String>> _chartSeries;

  int touchedGroupIndex = -1;

  void _initBarChartData() {
    final List<ChartData> data = [
      ChartData('Jan', 120, 100),
      ChartData('Feb', 100, 80),
      ChartData('Mar', 80, 60),
      ChartData('Apr', 60, 40),
      ChartData('Mei', 40, 20),
    ];

    _chartSeries = [
      charts.Series<ChartData, String>(
        id: 'Penjualan',
        domainFn: (ChartData sales, _) => sales.month,
        measureFn: (ChartData sales, _) => sales.penjualan,
        data: data,
      ),
      charts.Series<ChartData, String>(
        id: 'Pembelian',
        domainFn: (ChartData sales, _) => sales.month,
        measureFn: (ChartData sales, _) => sales.pembelian,
        data: data,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _initBarChartData();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleShowHide,
      child: Container(
        padding: const EdgeInsets.all(16),
        // color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'GRAFIK PENJUALAN TAHUN 2024',
                  style: buildTextStyle(
                    fontSize: 12,
                    fontWeight: 500,
                    color: MjkColor.lightBlack008,
                  ),
                ),
              ],
            ),
            Spacings.verSpace(12),
            const Divider(
              height: 1,
              color: MjkColor.lightBlack009,
            ),
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Spacings.verSpace(!_isShown ? 16 : 11),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: charts.BarChart(
                      _chartSeries,
                      animate: true,
                      animationDuration: const Duration(seconds: 1),
                      vertical: false,
                    ),
                  ),
                  // SizedBox(
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Column(
                  //         children: <Widget>[
                  //           Row(
                  //             children: <Widget>[
                  //               Container(
                  //                 width: 12,
                  //                 height: 12,
                  //                 decoration: const BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: MjkColor.blue006,
                  //                 ),
                  //               ),
                  //               Spacings.horSpace(8),
                  //               Text(
                  //                 'Penjualan',
                  //                 style: buildTextStyle(
                  //                   fontSize: 10,
                  //                   fontWeight: 400,
                  //                   color: MjkColor.black,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Spacings.verSpace(8),
                  //           Row(
                  //             children: <Widget>[
                  //               Container(
                  //                 width: 12,
                  //                 height: 12,
                  //                 decoration: const BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: Color(0xff990000),
                  //                 ),
                  //               ),
                  //               Spacings.horSpace(8),
                  //               Text(
                  //                 'Pembelian',
                  //                 style: buildTextStyle(
                  //                   fontSize: 10,
                  //                   fontWeight: 400,
                  //                   color: MjkColor.black,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Spacings.verSpace(24),
                  // SizedBox(
                  //   height: 180,
                  //   child: BarChart(
                  //     BarChartData(
                  //       maxY: maxY,
                  //       barTouchData: BarTouchData(
                  //         touchTooltipData: BarTouchTooltipData(
                  //           tooltipBgColor: Colors.grey,
                  //           getTooltipItem: (a, b, c, d) => null,
                  //         ),
                  //         touchCallback: (FlTouchEvent event, response) {
                  //           if (response == null || response.spot == null) {
                  //             setState(() {
                  //               touchedGroupIndex = -1;
                  //               showingBarGroups = List.of(rawBarGroups);
                  //             });
                  //             return;
                  //           }

                  //           touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                  //           setState(() {
                  //             if (!event.isInterestedForInteractions) {
                  //               touchedGroupIndex = -1;
                  //               showingBarGroups = List.of(rawBarGroups);
                  //               return;
                  //             }
                  //             showingBarGroups = List.of(rawBarGroups);
                  //             if (touchedGroupIndex != -1) {
                  //               var sum = 0.0;
                  //               for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
                  //                 sum += rod.toY;
                  //               }
                  //               final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

                  //               showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
                  //                 barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                  //                   return rod.copyWith(toY: avg);
                  //                 }).toList(),
                  //               );
                  //             }
                  //           });
                  //         },
                  //       ),
                  //       titlesData: FlTitlesData(
                  //         show: true,
                  //         rightTitles: AxisTitles(
                  //           sideTitles: SideTitles(showTitles: false),
                  //         ),
                  //         topTitles: AxisTitles(
                  //           sideTitles: SideTitles(showTitles: false),
                  //         ),
                  //         bottomTitles: AxisTitles(
                  //           sideTitles: SideTitles(
                  //             showTitles: true,
                  //             getTitlesWidget: bottomTitles,
                  //             reservedSize: 42,
                  //           ),
                  //         ),
                  //         leftTitles: AxisTitles(
                  //           sideTitles: SideTitles(
                  //             showTitles: true,
                  //             reservedSize: 48,
                  //             interval: leftAxisInterval,
                  //             getTitlesWidget: leftTitles,
                  //           ),
                  //         ),
                  //       ),
                  //       borderData: FlBorderData(
                  //         show: false,
                  //       ),
                  //       barGroups: showingBarGroups,
                  //       gridData: FlGridData(
                  //         show: true,
                  //         drawVerticalLine: false,
                  //         drawHorizontalLine: true,
                  //         horizontalInterval: leftAxisInterval,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleShowHide() {
    if (_animation.status != AnimationStatus.completed) {
      _animationController.forward();
    } else {
      _animationController.animateBack(
        0,
        duration: const Duration(milliseconds: 500),
      );
    }
    setState(() {
      _isShown = !_isShown;
    });
  }

  // void _toggleShowHide() {
  //   if (_animation.status != AnimationStatus.completed) {
  //     _animationController.forward();
  //   } else {
  //     _animationController.animateBack(
  //       0,
  //       duration: const Duration(milliseconds: 500),
  //     );
  //   }
  //   setState(() {
  //     _isShown = !_isShown;
  //   });
  // }
}

class ChartData {
  String month;
  int penjualan;
  int pembelian;

  ChartData(this.month, this.penjualan, this.pembelian);
}
