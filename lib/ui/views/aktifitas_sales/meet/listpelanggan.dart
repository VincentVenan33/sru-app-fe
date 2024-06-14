import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/networks/kunjungan_get_data_dto_network.dart';
import 'package:sru/core/view_models/meet/list_pelanggan_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/aktifitas_sales/meet/detailpelanggan.dart';
import 'package:sru/ui/views/navbar/navbar_sales_view.dart';

import '../../../widgets/search_bar.dart' as search;

class ListPelangganView extends ConsumerStatefulWidget {
  const ListPelangganView({super.key});

  @override
  ConsumerState<ListPelangganView> createState() => _ListPelangganViewState();

  List<int> getNumbersArray() {
    return [1, 2, 3, 4, 5];
  }
}

class _ListPelangganViewState extends ConsumerState<ListPelangganView> {
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;
  bool ditemukan = false;

  bool _isActiveAktif = false;
  bool _isActiveTidakAktif = false;

  @override
  void initState() {
    _isActiveAktif = true; // Misalnya tombol Aktif diaktifkan secara default
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<ListPelangganViewModel>(
      model: ListPelangganViewModel(
        kunjunganGetDataDTOApi: ref.read(kunjunganGetDataDTOApi),
      ),
      onModelReady: (ListPelangganViewModel model) => model.initModel(),
      builder: (_, ListPelangganViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: sruColor.white,
                body: RefreshIndicator(
                  onRefresh: () async {
                    model.initModel();
                    setState(() {
                      model.searchQuery = '';
                      _searchController.text = "";
                      model.fetchPelanggan(reload: true);
                    });
                  },
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
                    child: CustomScrollView(
                      slivers: [
                        SliverStickyHeader.builder(
                          sticky: true,
                          builder: (context, state) {
                            return Column(
                              children: [
                                Visibility(
                                  visible: tabIsHide == false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: Column(
                                    children: [
                                      AnimatedSlide(
                                        curve: Curves.easeIn,
                                        duration: const Duration(milliseconds: 200),
                                        offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                        child: Column(
                                          children: [
                                            AppBar(
                                              backgroundColor: sruColor.backgroundAtas,
                                              leading: IconButton(
                                                icon: const Icon(Icons.arrow_back),
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
                                              title: Text(
                                                'Data Pelanggan',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: tabIsHide == false ? 18 : 14,
                                                ),
                                              ),
                                              // centerTitle: true,
                                              toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                              actions: [
                                                IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Container(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 29,
                                                            vertical: 29,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: sruColor.lightBlack020,
                                                              width: 1,
                                                            ),
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(25),
                                                              topRight: Radius.circular(25),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  const Text(
                                                                    'Filter Data Pelanggan',
                                                                    textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    icon: const Icon(Icons.close),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacings.verSpace(22),
                                                              Container(
                                                                color: sruColor.transparent,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Spacings.verSpace(8),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(10),
                                                                      width: double.infinity,
                                                                      height: 58,
                                                                      decoration: BoxDecoration(
                                                                        color: sruColor.transparent,
                                                                        border: Border.all(
                                                                          color: sruColor.lightBlack020,
                                                                          width: 1,
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(40),
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          _buildButton(_isActiveAktif, "Sedang Ditemui",
                                                                              context, model, () {
                                                                            setState(() {
                                                                              _isActiveTidakAktif = false;
                                                                              _isActiveAktif = true;
                                                                              const String queryValue = '1';
                                                                              model.searchQuery = queryValue;
                                                                              model.fetchPelanggan(
                                                                                  reload: true,
                                                                                  searchKey:
                                                                                      'thkunjungan.status_check_in');
                                                                              Navigator.of(context).pop();
                                                                            });
                                                                          }),
                                                                          const SizedBox(width: 16),
                                                                          _buildButton(_isActiveTidakAktif,
                                                                              "Belum Ditemui", context, model, () {
                                                                            setState(() {
                                                                              _isActiveTidakAktif = true;
                                                                              _isActiveAktif = false;
                                                                              const String queryValue = '0';
                                                                              model.searchQuery = queryValue;
                                                                              model.fetchPelanggan(
                                                                                  reload: true,
                                                                                  searchKey:
                                                                                      'thkunjungan.status_check_in');
                                                                              Navigator.of(context).pop();
                                                                            });
                                                                          }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Spacings.verSpace(22),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.filter_alt_outlined,
                                                  ),
                                                  color: Colors.black,
                                                  iconSize: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
                                  ),
                                  color: sruColor.white,
                                  child: search.SearchBar(
                                      controller: _searchController,
                                      hintText: 'Cari',
                                      onFieldSubmitted: (value) {
                                        model.searchQuery = value;
                                        model.fetchPelanggan(reload: true);
                                      }),
                                ),
                              ],
                            );
                          },
                          sliver: SliverFillRemaining(
                            hasScrollBody: true,
                            fillOverscroll: true,
                            child: LazyLoadScrollView(
                              isLoading: model.busy,
                              onEndOfPage: () => model.isLastPage == false ? model.fetchPelanggan() : null,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.kunjungan.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.detailpelanggan,
                                          arguments: DetailPelangganParam(
                                            nomor: model.kunjungan[index].nomor,
                                            mode: 'view',
                                          ),
                                        );
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
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 140,
                                                  height: 20,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    color: sruColor.lightBlue006,
                                                  ),
                                                  child: Text(
                                                    model.kunjungan[index].kode,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: sruColor.white,
                                                      decoration: TextDecoration.none,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '${model.kunjungan[index].statuskunjungan}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: model.kunjungan[index].statuskunjungan == 'BELUM DITEMUI'
                                                        ? sruColor.red004
                                                        : model.kunjungan[index].statuskunjungan == 'SEDANG DITEMUI'
                                                            ? sruColor.yellow001
                                                            : model.kunjungan[index].statuskunjungan == 'SUDAH DITEMUI'
                                                                ? sruColor.green005
                                                                : sruColor
                                                                    .black, // Warna default jika status tidak dikenali
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(5),
                                            Row(
                                              children: [
                                                Text(
                                                  '${model.kunjungan[index].customer}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: sruColor.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacings.verSpace(5),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'Lokasi\n',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                      color: sruColor.lightBlack018,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '${model.kunjungan[index].alamat}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: sruColor.lightBlack018,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacings.verSpace(12),
                                            const Divider(
                                              height: 1,
                                              color: sruColor.lightBlack009,
                                            ),
                                            Spacings.verSpace(12),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  key: const Key("customer_FAB"),
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.addcheckinout,
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(
      bool isActive, String text, BuildContext context, ListPelangganViewModel model, VoidCallback onPressed) {
    Color foregroundColor = isActive ? sruColor.white : sruColor.lightBlack010;
    Color backgroundColor = isActive ? sruColor.lightBlue005 : sruColor.white;
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
