import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:mjk_apps/core/networks/barang_get_data_dto_network.dart';
import 'package:mjk_apps/core/view_models/produk/daftarorderjual_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';
import 'package:mjk_apps/ui/views/orderjual/edit/editadditemdetail.dart';

import '../../../shared/spacings.dart';
import '../../../widgets/search_bar.dart' as search;

class EditProdukKatalogParam {
  const EditProdukKatalogParam({
    this.nomor,
    this.mode,
    this.header,
    this.detailItem,
  });

  final int? nomor;
  final String? mode;
  final OrderJualGetDataContent? header;
  final List<OrderJualGetDataContent>? detailItem;
}

class EditProdukKatalogView extends ConsumerStatefulWidget {
  const EditProdukKatalogView({
    super.key,
    required this.param,
  });

  final EditProdukKatalogParam param;

  @override
  ConsumerState<EditProdukKatalogView> createState() => _EditProdukKatalogViewState();
}

class _EditProdukKatalogViewState extends ConsumerState<EditProdukKatalogView> {
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;
  bool ditemukan = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DaftarOrderJualViewModel>(
      model: DaftarOrderJualViewModel(
        barangGetDataDTOApi: ref.read(barangGetDataDTOApi),
      ),
      onModelReady: (DaftarOrderJualViewModel model) => model.initModel(),
      builder: (_, DaftarOrderJualViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: MjkColor.white,
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
                      SliverStickyHeader.builder(
                        sticky: true,
                        builder: (context, state) {
                          return Column(
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
                                        backgroundColor: MjkColor.backgroundAtas,
                                        title: Text(
                                          'Katalog Produk',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabIsHide == false ? 18 : 14,
                                          ),
                                        ),
                                        // centerTitle: true,
                                        toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: MjkColor.white,
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  bottom: 8,
                                ),
                                child: Column(
                                  children: [
                                    Spacings.verSpace(20),
                                    search.SearchBar(
                                      controller: _searchController,
                                      hintText: 'Cari Barang',
                                      onFieldSubmitted: (value) {
                                        model.searchQuery = value;
                                        model.fetchBarang(reload: true);
                                      },
                                    ),
                                    Visibility(
                                      visible: tabIsHide == false,
                                      child: Spacings.verSpace(16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        sliver: SliverFillRemaining(
                          hasScrollBody: true,
                          fillOverscroll: true,
                          child: LazyLoadScrollView(
                            isLoading: model.busy,
                            onEndOfPage: () => model.isLastPage == false ? model.fetchBarang() : null,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                model.initModel();
                                setState(() {
                                  model.searchQuery = '';
                                  _searchController.text = "";
                                  model.fetchBarang(reload: true);
                                });
                              },
                              child: GridView.builder(
                                itemCount: model.barang.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  mainAxisExtent: 265,
                                ),
                                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.editaddDetailCatalog,
                                        arguments: EditAddDetailOrderParam(
                                          nomor: model.barang[index].nomor,
                                          mode: 'view',
                                          header: widget.param.header,
                                          detailItem: widget.param.detailItem,
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(5.0),
                                                    topRight: Radius.circular(5.0),
                                                  ),
                                                  child: Image.network(
                                                    'https://indraco.com/gmb/tanpalogo/TUGUBUAYA/TB-301.png',
                                                    height: 132,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacings.verSpace(
                                            12,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.barang[index].kode,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 170,
                                                      child: Text(
                                                        model.barang[index].nama,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Kategori : ${model.barang[index].kategoribarang}',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Group : ${model.barang[index].groupbarang}',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Jenis : ${model.barang[index].jenispenjualan}',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Satuan : ${model.barang[index].satuan1}',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
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
            ),
          ),
        );
      },
    );
  }
}
