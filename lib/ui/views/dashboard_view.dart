import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/networks/dashboard_get_data_dto_network.dart';
import 'package:sru/core/services/authentication_service.dart';
import 'package:sru/core/utilities/string_utils.dart';
import 'package:sru/core/utilities/text_styles.dart';
import 'package:sru/core/view_models/dashboard_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  bool anyNotif = false;
  void Function()? onNotificationButtonPressed;

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DashboardViewModel>(
      model: DashboardViewModel(
        authenticationService: ref.read(authProvider),
        dashboardGetDataDTOApi: ref.read(dashboardGetDataDTOApi),
      ),
      onModelReady: (DashboardViewModel model) => model.initModel(),
      builder: (_, DashboardViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: sruColor.white,
                body: NotificationListener<UserScrollNotification>(
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
                  child: CustomScrollView(
                    slivers: [
                      SliverStickyHeader(
                        sticky: true,
                        header: Column(
                          children: [
                            Visibility(
                              visible: tabIsHide == false,
                              maintainState: true,
                              maintainAnimation: true,
                              child: AnimatedSlide(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 200),
                                offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                child: Column(
                                  children: [
                                    AppBar(
                                      // systemOverlayStyle: SystemUiOverlayStyle.light,
                                      automaticallyImplyLeading: false,
                                      backgroundColor: sruColor.lightBlue005,
                                      foregroundColor: Colors.transparent,
                                      elevation: 0,
                                      toolbarHeight: 60,
                                      flexibleSpace: Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: sruColor.lightBlack001,
                                                blurRadius: 1.0,
                                                offset: Offset(0.0, 0.75))
                                          ],
                                          color: sruColor.lightBlue005,
                                        ),
                                        child: SafeArea(
                                          bottom: false,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 70,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/icons/sru.png',
                                                    ),
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                  // color: Colors.white,
                                                ),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(10, 0),
                                                child: Text(
                                                  'CV Sido Raya Utama',
                                                  style: buildTextStyle(
                                                    fontSize: 16,
                                                    fontWeight: 500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '',
                                                  textAlign: TextAlign.center,
                                                  style: buildTextStyle(
                                                    fontSize: 18,
                                                    fontWeight: 500,
                                                    color: Colors.white,
                                                    fontHeight: 22.27,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => model.requestLogout(),
                                                child: const ImageIcon(
                                                  AssetImage(
                                                    'assets/icons/ic_baseline-log-out.png',
                                                  ),
                                                  // size: 25,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 60,
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Spacings.verSpace(20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                color: sruColor.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'LIST SO',
                                          style: buildTextStyle(
                                            fontSize: 16,
                                            fontWeight: 500,
                                            color: sruColor.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacings.verSpace(12),
                                    const Divider(
                                      height: 1,
                                      color: sruColor.lightBlack009,
                                    ),
                                    Spacings.verSpace(21),
                                  ],
                                ))
                          ],
                        ),
                        sliver: SliverFillRemaining(
                          hasScrollBody: true,
                          fillOverscroll: true,
                          child: Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async => model.initModel(),
                                  child: ListView.separated(
                                    separatorBuilder: (_, __) => Spacings.verSpace(12),
                                    itemCount: model.orderjual.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(5.914), // Add border radius here
                                                        color: const Color.fromRGBO(36, 149, 174, 0.80),
                                                      ),
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.only(
                                                        top: 5,
                                                        left: 9,
                                                        right: 9.92,
                                                        bottom: 4.46,
                                                      ),
                                                      child: Text(
                                                        model.orderjual[index].kode,
                                                        style: const TextStyle(
                                                          color: sruColor.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacings.verSpace(10.43),
                                                    Text(
                                                      StringUtils.rupiahFormat(
                                                        double.parse(model.orderjual[index].total != null
                                                            ? '${model.orderjual[index].total}'
                                                            : '0'),
                                                        symbol: 'Rp. ',
                                                      ),
                                                      style: buildTextStyle(
                                                        fontSize: 15.376,
                                                        fontWeight: 400,
                                                        color: sruColor.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${model.orderjual[index].customer}',
                                                      style: buildTextStyle(
                                                        fontSize: 15.376,
                                                        fontWeight: 700,
                                                        color: sruColor.black,
                                                      ),
                                                    ),
                                                    Spacings.verSpace(10.43),
                                                    Text(
                                                      model.orderjual[index].tanggal != null
                                                          ? DateFormat('dd MMMM yyyy').format(
                                                              DateTime.tryParse(model.orderjual[index].tanggal!) ??
                                                                  DateTime.now(),
                                                            )
                                                          : '', // Jika tanggal null atau kosong, tampilkan string kosong
                                                      style: const TextStyle(
                                                        fontSize: 15.376,
                                                        fontWeight: FontWeight.w700,
                                                        color: sruColor.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(9),
                                            const Column(
                                              children: [
                                                Divider(
                                                  height: 1,
                                                  color: sruColor.lightBlack009,
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(20.82),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
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
}
