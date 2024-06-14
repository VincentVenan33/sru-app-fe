import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/view_models/meet/createcheckinout_view_model.dart';
import 'package:sru/core/view_models/view_model.dart';
import 'package:sru/ui/shared/loading_overlay.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';

import '../../../widgets/search_bar.dart' as search;

class AddPelanggan extends ConsumerStatefulWidget {
  const AddPelanggan({
    super.key,
    required this.viewModel,
  });
  final AddCheckInOutViewModel viewModel;
  @override
  ConsumerState<AddPelanggan> createState() => _AddPelangganState();
}

class _AddPelangganState extends ConsumerState<AddPelanggan> {
  final TextEditingController pelangganController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  // ignore: unused_field
  bool _isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<AddCheckInOutViewModel>(
      model: widget.viewModel,
      onModelReady: (AddCheckInOutViewModel model) => model.fetchCustomer(reload: true),
      builder: (_, AddCheckInOutViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: Scaffold(
              backgroundColor: sruColor.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                  setState(
                    () {
                      model.searchQuery = '';
                      _searchController.text = "";
                      model.fetchCustomer(reload: true);
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
                                      backgroundColor: sruColor.backgroundAtas,
                                      title: Text(
                                        'Tambah Pelanggan',
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
                              color: sruColor.white,
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                              ),
                              child: Column(
                                children: [
                                  Spacings.verSpace(20),
                                  search.SearchBar(
                                    controller: _searchController,
                                    hintText: 'Cari Customer',
                                    onFieldSubmitted: (value) {
                                      model.searchQuery = value;
                                      model.fetchCustomer(reload: true);
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
                            isLoading: model.isLoadingMore,
                            onEndOfPage: () {
                              if (!model.isLastPage && !model.isLoadingMore) {
                                model.initData();
                              }
                            },
                            child: Stack(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.customer.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      tileColor: sruColor.transparent,
                                      title: Text(
                                        model.customer[index].nama,
                                      ),
                                      groupValue: model.selectedCustomer,
                                      value: model.customer[index],
                                      onChanged: (value) {
                                        setState(() {
                                          model.setselectedcustomer(value);
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
      color: sruColor.white,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: sruColor.blue001,
          ),
        ),
      ),
    );
  }
}
