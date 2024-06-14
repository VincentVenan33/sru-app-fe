import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/view_models/customer/updatecustomer_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';
import 'package:mjk_apps/ui/shared/loading_overlay.dart';
import 'package:mjk_apps/ui/shared/spacings.dart';
import 'package:mjk_apps/ui/shared/unfocus_helper.dart';

import '../../../widgets/search_bar.dart' as search;

class UpdateDesa extends ConsumerStatefulWidget {
  const UpdateDesa({
    super.key,
    required this.viewModel,
  });
  final UpdateCustomerViewModel viewModel;
  @override
  ConsumerState<UpdateDesa> createState() => _UpdateDesaState();
}

class _UpdateDesaState extends ConsumerState<UpdateDesa> {
  final TextEditingController desaController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController kabupatenController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  // ignore: unused_field
  bool _isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<UpdateCustomerViewModel>(
      model: widget.viewModel,
      onModelReady: (UpdateCustomerViewModel model) => model.fetchDesa(reload: true),
      builder: (_, UpdateCustomerViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: Scaffold(
              backgroundColor: MjkColor.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                  setState(
                    () {
                      model.searchQuery = '';
                      _searchController.text = "";
                      model.fetchDesa(reload: true);
                      _isLoadingMore = false;
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
                                        'Edit Desa',
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
                              ),
                              child: Column(
                                children: [
                                  Spacings.verSpace(20),
                                  search.SearchBar(
                                    controller: _searchController,
                                    hintText: 'Cari Desa',
                                    onFieldSubmitted: (value) {
                                      model.searchQuery = value;
                                      model.fetchDesa(reload: true);
                                      _isLoadingMore = false;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sliver: SliverFillRemaining(
                          hasScrollBody: true,
                          fillOverscroll: true,
                          child: LazyLoadScrollView(
                            isLoading: model.busy,
                            onEndOfPage: () {
                              if (!model.isLastPage && !model.isLoadingMore) {
                                model.initData();
                              }
                            },
                            child: Stack(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.desa.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      tileColor: MjkColor.transparent,
                                      title: Text(
                                        '${model.desa[index].nama}, ${model.desa[index].kecamatan}, ${model.desa[index].kota}, ${model.desa[index].provinsi}',
                                      ),
                                      groupValue: model.selectedDesa,
                                      value: model.desa[index],
                                      onChanged: (value) {
                                        setState(() {
                                          model.searchQuery = '';
                                          _searchController.text = "";
                                          model.fetchDesa(reload: true);
                                          model.setselecteddesa(value);
                                        });
                                        Navigator.of(context).pop(true);
                                      },
                                    );
                                  },
                                ),
                                if (model.isLoadingMore)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: buildLoadingIndicator(), // Menampilkan indikator loading di bawah ListView
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
          ),
        );
      },
    );
  }

  Widget buildLoadingIndicator() {
    return Container(
      color: MjkColor.white,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: MjkColor.blue001,
          ),
        ),
      ),
    );
  }
}
