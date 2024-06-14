import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/networks/get_data_dto_network.dart';
import 'package:mjk_apps/core/utilities/string_utils.dart';
import 'package:mjk_apps/core/view_models/customer/customer_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/detailcustomer.dart';
import 'package:mjk_apps/ui/views/aktifitas_sales/customer/updatecustomer.dart';
import 'package:mjk_apps/ui/views/navbar/navbar_sales_view.dart';

import '../../../widgets/search_bar.dart' as search;

class CustomerView extends ConsumerStatefulWidget {
  const CustomerView({
    super.key,
  });

  @override
  ConsumerState<CustomerView> createState() => _CustomerViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _CustomerViewState extends ConsumerState<CustomerView> {
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  bool _isActiveAktif = false;
  bool _isActiveTidakAktif = false;

  @override
  void initState() {
    _isActiveAktif = true; // Misalnya tombol Aktif diaktifkan secara default
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<CustomerViewModel>(
      model: CustomerViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
      ),
      onModelReady: (CustomerViewModel model) => model.initModel(),
      builder: (_, CustomerViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: MjkColor.white,
                body: RefreshIndicator(
                  onRefresh: () async {
                    model.initModel();
                    setState(
                      () {
                        model.searchQuery = '';
                        _searchController.text = "";
                        model.fetchDaftarCustomer(reload: true);
                      },
                    );
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
                        SliverStickyHeader(
                          sticky: true,
                          header: Column(
                            children: [
                              AnimatedOpacity(
                                opacity: tabIsHide ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn, // Kurva animasi
                                child: AnimatedSlide(
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 500),
                                  offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                  child: Column(
                                    children: [
                                      AppBar(
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
                                          icon: const Icon(Icons.arrow_back),
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
                                                        color: MjkColor.lightBlack020,
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
                                                          color: MjkColor.transparent,
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
                                                                  color: MjkColor.transparent,
                                                                  border: Border.all(
                                                                    color: MjkColor.lightBlack020,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(40),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    _buildButton(
                                                                        _isActiveAktif, "Aktif", context, model, () {
                                                                      setState(() {
                                                                        _isActiveTidakAktif = false;
                                                                        _isActiveAktif =
                                                                            true; // Pastikan status tombol Aktif diatur ke false
                                                                        const String queryValue = '1';
                                                                        model.searchQuery = queryValue;
                                                                        model.fetchDaftarCustomer(
                                                                            reload: true,
                                                                            searchKey: 'mhrelasi.status_aktif');
                                                                        Navigator.of(context).pop();
                                                                      });
                                                                    }),
                                                                    const SizedBox(width: 16),
                                                                    _buildButton(_isActiveTidakAktif, "Tidak Aktif",
                                                                        context, model, () {
                                                                      setState(() {
                                                                        _isActiveTidakAktif =
                                                                            true; // Memperbarui status tombol Tidak Aktif
                                                                        _isActiveAktif =
                                                                            false; // Pastikan status tombol Aktif diatur ke false
                                                                        const String queryValue = '0';
                                                                        model.searchQuery = queryValue;
                                                                        model.fetchDaftarCustomer(
                                                                            reload: true,
                                                                            searchKey: 'mhrelasi.status_aktif');
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
                              ),
                              AnimatedSlide(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 500),
                                offset: tabIsHide == false ? Offset.zero : const Offset(0, -0.8),
                                child: Container(
                                  color: MjkColor.white,
                                  padding: const EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Spacings.verSpace(20),
                                      search.SearchBar(
                                        controller: _searchController,
                                        hintText: 'Cari Nama',
                                        onFieldSubmitted: (value) {
                                          model.searchQuery = value;
                                          model.fetchDaftarCustomer(reload: true);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sliver: SliverFillRemaining(
                            hasScrollBody: true,
                            fillOverscroll: true,
                            child: LazyLoadScrollView(
                              isLoading: model.busy,
                              onEndOfPage: () => model.isLastPage == false ? model.fetchDaftarCustomer() : null,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  bottom: 74,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.daftarcustomer.length,
                                  itemBuilder: (context, index) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.detailcustomer,
                                          arguments: DetailCustomerParam(
                                            nomor: model.daftarcustomer[index].nomor,
                                            mode: 'view',
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Color(MjkColor.transparent.value),
                                        surfaceTintColor: MjkColor.transparent,
                                        shadowColor: MjkColor.transparent,
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.zero,
                                          ),
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 20,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        color: MjkColor.lightBlue006,
                                                      ),
                                                      child: Text(
                                                        model.daftarcustomer[index].kode,
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: MjkColor.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      model.daftarcustomer[index].nama,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: MjkColor.black,
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
                                                        text: 'Omset\n',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.normal,
                                                          color: MjkColor.lightBlack018,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: StringUtils.rupiahFormat(
                                                          double.parse(model.daftarcustomer[index].omset != null
                                                              ? '${model.daftarcustomer[index].omset}'
                                                              : '0'),
                                                          symbol: 'Rp. ',
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: MjkColor.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.verSpace(12),
                                                const Divider(
                                                  height: 1,
                                                  color: MjkColor.lightBlack009,
                                                ),
                                                Spacings.verSpace(12),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  style: const ButtonStyle(
                                                    backgroundColor: MaterialStatePropertyAll(
                                                      MjkColor.yellow,
                                                    ),
                                                    shadowColor: MaterialStatePropertyAll(
                                                      MjkColor.transparent,
                                                    ),
                                                    surfaceTintColor: MaterialStatePropertyAll(
                                                      MjkColor.yellow,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      Routes.editcustomer,
                                                      arguments: UpdateCustomerParam(
                                                        nomor: model.daftarcustomer[index].nomor,
                                                        mode: 'edit',
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: MjkColor.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
                      Routes.addcustomer,
                    );
                  },
                  backgroundColor: MjkColor.floatButtonSalesColor,
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
      bool isActive, String text, BuildContext context, CustomerViewModel model, VoidCallback onPressed) {
    Color foregroundColor = isActive ? MjkColor.white : MjkColor.lightBlack010;
    Color backgroundColor = isActive ? MjkColor.lightBlue005 : MjkColor.white;
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
